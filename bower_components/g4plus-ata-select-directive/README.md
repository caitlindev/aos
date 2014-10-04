# G4 ATA Select Directive

This directive implements a component within apps to allow the user to select an ATA code by searching via chapter.

## Usage example

The easiest way is to add `g4plus.ata-select` as a module in your `app.coffee`.

This is an example of use within your template file:

```jade
div(g4ata-select, model="selectedCodes")
```

Where `model` should be a bound data object in your controller. When editing a record, this component should pull in this existing data, and the component will be used to add to or remove from this list. When creating a new record, this data will be updated from within this component for use in any scope.

An example of the type of data that should be bound is here:

```
"ata-code": {
    "chapter": "03",
    "section": "10"
  }
```