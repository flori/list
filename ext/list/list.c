#include "list.h"

VALUE cList;
ID id_at;

static List_Meta *List_Meta_alloc()
{
    List_Meta *new = ALLOC(List_Meta);

    if (new) {
        memset(new, 0, sizeof(List_Meta));
    }

    return new;
}


static List_Node *List_Node_alloc(VALUE value)
{
    List_Node *new = ALLOC(List_Node);

    if (new) {
        memset(new, 0, sizeof(List_Node));
        new->value = value;
        return new;
    } else {
        return NULL;
    }
}

static List_Node *List_insert(List_Node *ptr, VALUE value, long position)
{
    List_Node *start = ptr, *prev = NULL, *new = List_Node_alloc(value);

    assert(position >= 0);
    while (position > 0 && ptr) {
        prev = ptr;
        ptr = ptr->next;
        --position;
    }
    assert(position == 0);

    if (prev) {
        prev->next = new;
        new->next = ptr;
        return start;
    } else {
        new->next = ptr;
        return new;
    }
}

static List_Node *List_delete(List_Node *ptr, long position)
{
    List_Node *start = ptr, *prev = NULL;

    while (position > 0 && ptr) {
        prev = ptr;
        ptr = ptr->next;
        --position;
    }

    if (ptr) {
        if (prev) {
            prev->next = ptr->next;
            xfree(ptr);
            return start;
        } else {
            start = ptr->next;
            xfree(ptr);
            return start;
        }
    } else {
        xfree(start);
        return NULL;
    }
}


static void List_mark(void *ptr)
{
    const List_Meta *list = (List_Meta *) ptr;
    List_Node *node = list->node;

    while (node) {
        rb_gc_mark_maybe(node->value);
        node = node->next;
    }
}

static size_t List_memsize(const void *ptr)
{
    const List_Meta *list = (List_Meta *) ptr;

    return sizeof(*list) + list->size * sizeof(VALUE);
}

static void List_free(void *ptr)
{
    List_Meta *list = (List_Meta *) ptr;
    List_Node *node = list->node, *n;

    while (node) {
        n = node->next;
        xfree(node);
        node = n;
    }

    xfree(ptr);
}

static const rb_data_type_t List_Meta_type = {
  "List",
  { List_mark, List_free, List_memsize },
};

static VALUE rb_List_allocate(VALUE klass)
{
    List_Meta *list = List_Meta_alloc();

    return TypedData_Make_Struct(klass, List_Meta, &List_Meta_type, list);
}

static VALUE rb_List_insert(VALUE self, VALUE value, VALUE opts)
{
    VALUE at;
    long position;
    List_Node *done;
    ID id = id_at;
    GET_STRUCT(self);

    rb_get_kwargs(opts, &id, 0, 1, &at);
    position = FIX2INT(at);

    if (position < 0) {
        position = list->size + position + 1;
    }

    done = NULL;
    if (position >= 0 && position <= list->size) {
        done = list->node = List_insert(list->node, value, position);
    }
    if (done) {
        ++list->size;
        return self;
    } else {
        return Qnil;
    }
}

static VALUE rb_List_delete(VALUE self, VALUE opts)
{
    VALUE at;
    long position;
    int done;
    ID id = id_at;
    GET_STRUCT(self);

    rb_get_kwargs(opts, &id, 0, 1, &at);
    position = FIX2INT(at);

    if (position < 0) {
        position = list->size + position;
    }

    done = 0;
    if (list->size > 0 && position >= 0 && position <= list->size) {
        list->node = List_delete(list->node, position);
        done = 1;
    }
    if (done) {
        --list->size;
        return self;
    } else {
        return Qnil;
    }
}

static VALUE rb_List_size(VALUE self)
{
    GET_STRUCT(self);

    return INT2FIX(list->size);
}

static VALUE rb_List_empty_p(VALUE self)
{
    GET_STRUCT(self);

    return list->size == 0 ? Qtrue : Qfalse;
}

static VALUE rb_List_each(VALUE self)
{
    List_Node *node;
    GET_STRUCT(self);
    node = list->node;

    RETURN_SIZED_ENUMERATOR(self, 0, 0, list->size);
    for (; node; node = node->next) {
        rb_yield(node->value);
    }

    return self;
}

static VALUE rb_List_index(VALUE self, VALUE value)
{
    List_Node *node;
    long i;
    GET_STRUCT(self);
    node = list->node;

    for (i = 0; node; i++, node = node->next) {
        if (rb_eql(node->value, value)) return INT2FIX(i);
    }

    return Qnil;
}

static VALUE rb_List_s_aref(int argc, VALUE *argv, VALUE klass)
{
    long i;
    VALUE obj = rb_List_allocate(klass);
    GET_STRUCT(obj);

    for (i = 0; i < argc; i++) {
        list->node = List_insert(list->node, argv[i], i);
        ++list->size;
    }

    return obj;
}

void Init_list()
{
    cList = rb_define_class("List", rb_cObject);
    rb_include_module(cList, rb_mEnumerable);

    rb_define_alloc_func(cList, rb_List_allocate);
    rb_define_singleton_method(cList, "[]", rb_List_s_aref, -1);
    rb_define_method(cList, "insert", rb_List_insert, 2);
    rb_define_method(cList, "delete", rb_List_delete, 1);
    rb_define_method(cList, "size", rb_List_size, 0);
    rb_define_method(cList, "empty?", rb_List_empty_p, 0);
    rb_define_method(cList, "each", rb_List_each, 0);
    rb_define_method(cList, "index", rb_List_index, 1);

    CONST_ID(id_at, "at");
}
