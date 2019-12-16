## Black Thursday Lite

A business is only as smart as its data. Let's build a system to manage our data and execute business intelligence queries against the data from a typical e-commerce business.

Project Overview
-----------------

### Learning Goals

*   Use tests to drive both the design and implementation of code
*   Decompose a large application into components
*   Design a solution that is functional, readable, maintainable, and testable

### Setup and Submission

1.  Fork this repository
1.  Clone _your_ forked repository
1.  Complete as much of the activity below as you have time for during this exploration
1.  Push your code to the master branch of your repository
1.  Submit a Pull Request back to the turingschool-examples repository (this repo)


### Key Concepts

From a technical perspective, this project will emphasize:

*   CSV I/O
*   Database Operations
*   Encapsulating Responsibilities

## Building Your SalesEngine

### Data Access Layer (DAL) and Object Relational Mapping (ORM)

The idea of a *DAL* is to write classes which load and parse your raw data, allowing your system to then interact with rich ruby objects to do more complex analysis.

In many applications, including the Rails projects you will build in Module 2, the DAL is incorporated in an ORM that works with a database to load and parse data into rich ruby objects.

In this exercise, we'll build the beginnings of a DAL with some ORM-like functionality by building the classes described below:

In order to interact with our DAL, let's tie everything together with one common root, a `SalesEngine` instance:

```ruby
sales_engine = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
```

From there we can find the child instances:

*   `item_collection` returns an array of all items (This method will probably (definitely) end up referencing an instance of `ItemCollection`)
*   `merchant_collection` returns an array of all merchants (This method will probably (definitely) end up referencing an instance of `MerchantCollection`)

### `MerchantCollection`

The `MerchantCollection` is responsible for holding and searching our `Merchant`
instances. It offers the following methods:

*   `all` - returns an array of all known `Merchant` instances
*   `find(merchant_id)` - returns either `nil` or an instance of `Merchant` with a matching ID

The data can be found in `data/merchants.csv` so the instance is created and used like this:

```ruby
sales_engine = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

merchant_collection = sales_engine.merchants
merchant = merchant_collection.find(34)
# => <Merchant>
```

### `Merchant`

The merchant is one of the critical concepts in our data hierarchy.

*   `id` - returns the integer id of the merchant
*   `name` - returns the name of the merchant

We create an instance like this:

```ruby
merchant = Merchant.new({:id => 5, :name => "Turing School"})
```

### `ItemCollection`

The `ItemCollection` is responsible for holding and searching our `Item`
instances. This object represents one line of data from the file `items.csv`.

It offers the following methods:

*   `all` - returns an array of all known `Item` instances
*   `where(id)` - returns either an empty array, or an array of all items with a merchant_id matching the given argument.

It's initialized and used like this:

```ruby
sales_engine = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})

merchant_collection = sales_engine.merchants
item_collection = sales_engine.items
merchant = merchant_collection.find(34)
items = item_collection.where(merchant.id)
# => [<Item>, <Item>, ...., <Item>]
```

### `Item`

The Item instance offers the following methods:

*   `id` - returns the integer id of the item
*   `name` - returns the name of the item
*   `description` - returns the description of the item
*   `unit_price` - returns the price of the item
*   `merchant_id` - returns the integer merchant id of the item

We create an instance like this:

```ruby
item = Item.new({
  :id          => 1,
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => 1099,
  :merchant_id => 2
})
```

### Increasing Our Search Capabilities

Now that you can search for a merchant by id, and search for items by merchant id, let's change our Item's `where` method to satisfy the following interaction pattern:

```ruby
sales_engine = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})

merchant_collection = sales_engine.merchants
item_collection = sales_engine.items
all_pencils = item_collection.where({merchant_id: 34})
# => [<Item>, <Item>, <Item>]
all_pencils = item_collection.where({name: 'Pencil'})
# => [<Item>, <Item>, <Item>]
all_fifty_cent_items = item_collection.where({price: 50})
# => [<Item>, <Item>, <Item>]
```

With this new implementation of `where`, you should be able to send a key/value pair into the method to return all items where the attribute(key) matches the value given.


### Creating, Updating, and Destroying objects

Up to this point, we have only asked for information, but in the real world, we would not only need to `Read` information from our database, but also `Create`, `Update`, and `Destroy` records.  Put together, these 4 actions (CRUD) constitute everything you might need to do to a record in a database.  Let's practice these concepts by updating our `MerchantCollection` class to respond to the following methods:

* `create({name: 'Monster Merchant'})` - This should create a new instance of Merchant with a unique ID, and store it in our Merchant Collection.
* `destroy(34)` - This should find the Merchant with a given id and remove them from the Merchant Collection.

And, let's update our `Merchant` class to respond to the following methods:

* `update({name: 'New Merchant Name'})` - this should change the name of the Merchant instance to the given value.


## Wrap Up

You have now created your very own DAL/ORM!!  Going into Mod2, you will start using the ActiveRecord ORM (much more powerful that the one we created today).  If you are interested in learning more, take a look at the resources below:

* [What is an ORM](https://blog.bitsrc.io/what-is-an-orm-and-why-you-should-use-it-b2b6f75f5e2a)
* [ActiveRecord Docs](https://guides.rubyonrails.org/active_record_basics.html)
