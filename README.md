# fresh API

Powers `fresh search`.

## API

### GET /directory

Returns the entire [directory]:
  
- `200` responds with a plain text list of fresh lines

### GET /directory?q=:query

Search the [directory] for `query`:
  
- `200` responds with a plain text list of fresh lines matching `query`
- `500` something went wrong

## Development

To run the app locally:

```
memcached # start memcached
rackup
```

# License

MIT

[directory]: https://github.com/freshshell/fresh/wiki/Directory