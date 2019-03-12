{
  "train_data_path": "a5-data/de_en.train",
  "validation_data_path": "a4-data/de_en.dev",
  "dataset_reader": {
    "type": "mt_classifier_reader",
    // "use_subtrees": false,
    // "granularity": "2-class",
    "token_indexers": {
        "tokens": {
            "type": "single_id",
            "lowercase_tokens": true
        },
        "elmo": {
            "type": "elmo_characters"
        }
    }
  },
  "model": {
    "type": "mt_classifier",
    "text_field_embedder": {
        "type": "basic",
        "token_embedders": {
            "tokens": {
                "type": "embedding",
                "embedding_dim": 300,
                "pretrained_file": "/cse/web/courses/cse447/19wi/assignments/resources/word2vec/GoogleNews-vectors-negative300.txt.gz",
                "trainable": true
            },
            "elmo": {
                "type": "elmo_token_embedder",
                "options_file": "https://s3-us-west-2.amazonaws.com/allennlp/models/elmo/2x4096_512_2048cnn_2xhighway/elmo_2x4096_512_2048cnn_2xhighway_options.json",
                "weight_file": "https://s3-us-west-2.amazonaws.com/allennlp/models/elmo/2x4096_512_2048cnn_2xhighway/elmo_2x4096_512_2048cnn_2xhighway_weights.hdf5",
                "do_layer_norm": false,
                "dropout": 0.5
            }
        }
    },
    "origin_language_encoder": {
        "type": "lstm",
        "input_size": 1324,
        "hidden_size": 256,
        "num_layers": 2,
        "dropout": 0.2,
        "bidirectional": true
    },
    "target_language_encoder": {
        "type": "lstm",
        "input_size": 1324,
        "hidden_size": 256,
        "num_layers": 2,
        "dropout": 0.2,
        "bidirectional": true
    },
    "classifier_feedforward": {
      "input_dim": 512,
      "num_layers": 2,
      "hidden_dims": [128, 2],
      "activations": ["tanh", "linear"],
      "dropout": [0.1, 0]
    }
  },
  "iterator": {
    "type": "basic",
    "batch_size": 64
  },
  "trainer": {
      "optimizer": {
          "type": "adagrad",
          "lr" : 0.01,
          "weight_decay" : 0.001
          // "patience": 12
          // "momentum" : 0.1
      },
      "patience": 15,
      "num_epochs": 100,
      "cuda_device": 0,
      "num_serialized_models_to_keep" : 0,
      "validation_metric" : "+accuracy",
      "learning_rate_scheduler" : {
          "type" : "reduce_on_plateau",
          "factor": 0.3,
          "patience" : 7
      }
  }
}