# blast-indexer

Blast indexer container. Blast is a full text search server on top of Bleve (http://blevesearch.com).

You can use Blast/Bleve as a lightweight alternative to Elasticsearch.

See more about Blast API and capabilities at https://github.com/mosuka/blast

## Usage

* docker-compose.yml

```yml
version: '3.7'

services:

  blast-indexer1:
    image: flaviostutz/blast-indexer
    ports:
      - 6000:6000
    volumes:
      - /yourvolumedir:/data
```

* Index sample documents

```shell
curl -X PUT \
  http://localhost:6000/v1/documents \
  -H 'Content-Type: application/json' \
  -d '{
  "id": "a1",
  "fields": {
    "title": "Motor de busca",
    "text": "Motor de pesquisa (português europeu) ou ferramenta de busca (português brasileiro) ou buscador (em inglês: search engine) é um programa desenhado para procurar palavras-chave fornecidas pelo utilizador em documentos e bases de dados. No contexto da internet, um motor de pesquisa permite procurar palavras-chave em documentos alojados na world wide web, como aqueles que se encontram armazenados em websites.",
    "timestamp": "2019-11-09T14:38:00Z",
    "_type": "sample1"
  }
}'
```

```shell
curl -X PUT \
  http://localhost:6000/v1/documents \
  -H 'Content-Type: application/json' \
  -d '{
  "id": "a2",
  "fields": {
    "title": "Anything here!",
    "text": "You use anything to talk about something that might happen. He was ready for anything. You use anything to talk about each thing of a particular kind. Do you like chocolate? – I like anything sweet. Internet is here to help!",
    "timestamp": "2019-01-09T10:28:00Z",
    "_type": "sample1"
  }
}'
```

* Simple search on documents

```shell
curl -X POST \
  http://localhost:6000/v1/search \
  -H 'Content-Type: application/json' \
  -d '  
{
  "search_request": {
    "query": {
      "query": "+_all:internet"
    }
  }
}'
```

* Advanced search results on documents

```shell
curl -X POST \
  http://localhost:6000/v1/search \
  -H 'Content-Type: application/json' \
  -d '  
{
  "search_request": {
    "query": {
      "query": "+_all:internet"
    },
    "size": 10,
    "from": 0,
    "fields": [
      "*"
    ],
    "sort": [
      "-_score",
      "_id",
      "-timestamp"
    ],
    "facets": {
      "Type count": {
        "size": 10,
        "field": "_type"
      },
      "Timestamp range": {
        "size": 10,
        "field": "timestamp",
        "date_ranges": [
          {
            "name": "2001 - 2010",
            "start": "2001-01-01T00:00:00Z",
            "end": "2010-12-31T23:59:59Z"
          },
          {
            "name": "2011 - 2020",
            "start": "2011-01-01T00:00:00Z",
            "end": "2020-12-31T23:59:59Z"
          }
        ]
      }
    },
    "highlight": {
      "style": "html",
      "fields": [
        "title",
        "text"
      ]
    }
  }
}'
```

