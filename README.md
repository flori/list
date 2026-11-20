# List 📋

## Description

A Ruby gem for creating and manipulating dynamic linked lists with efficient
insertion and deletion operations at arbitrary indices.

## Installation

Build the gem, then install the local package:

```bash
rake build
gem install pkg/list-0.0.1.gem
```

> **Note:** `gem install list` on RubyGems will install a different
> gem. Always use the local `pkg/` path.

## Usage

### 1. Basic Usage

```ruby
require 'list'

# Create a new list
list = List.new

# Insert elements
list.insert :foo, at: 0
list.insert :bar, at: 1
list.insert :baz, at: 0

# Access elements
puts list[0]  # => :baz
puts list[-1] # => :bar

# Delete elements
list.delete at: 0
puts list.size # => 1

# Convert to array
list.to_a # => [:bar, :foo]
```

### 2. Pre-filled List

```ruby
# Create list with initial elements
list = List[1, 2, 3, 4, 5]

# Insert at specific positions
list.insert :zero, at: 0
list.insert :six, at: -1
list.to_a # => [:zero, 1, 2, 3, 4, 5, :six]
```

### 3. Working with Enumerable Methods

```ruby
list = List[1, 2, 3, 4, 5]

# Use enumerable methods
list.map { |x| x * 2 }      # => [2, 4, 6, 8, 10]
list.select { |x| x.even? } # => [2, 4]
```

## API Reference

### Class Methods

- `List[](*elements)` - Create a new list with initial elements
- `List.new` - Create an empty list

### Instance Methods

- `#insert(value, at: index)` - Insert value at specified index
- `#delete(at: index)` - Delete element at specified index
- `#size` - Return number of elements
- `#empty?` - Check if list is empty
- `#index(value)` - Find index of first occurrence of value
- `#each` - Iterate over elements
- `#[]` - Access element at index
- `#[]=` - Set element at index
- `#to_a` - Convert to Ruby Array

## Author

[Florian Frank](mailto:flori@ping.de) 🧑‍💻

## License

[MIT License](./LICENSE) 📄
