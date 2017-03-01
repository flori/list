#include <ruby.h>
#include <assert.h>

#ifndef _LIST_H_
#define _LIST_H_

typedef struct List_NodeStruct List_Node;

struct List_NodeStruct {
  VALUE value;
  List_Node *next;
};

typedef struct List_MetaStruct List_Meta;

struct List_MetaStruct {
  List_Node *node;
  long size;
};

static const rb_data_type_t List_Meta_type;

#define GET_STRUCT(self)\
    List_Meta *list;\
    TypedData_Get_Struct(self, List_Meta, &List_Meta_type, list)

#endif
