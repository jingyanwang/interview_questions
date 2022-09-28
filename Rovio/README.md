# Jingyan Wang's solution of churn prediction

## purpose

The idea is to use a deep learning model to predict if a player will leave or stay after 7-th day since the registration

## data

1. player's profile
2. player's activities/events

## model design

The deep learning model has two input channels:

1. profile channel: This channel takes the profile attributes as inputs, and embeds these attributes as vectors 

2. event channel: This channel takes the player's events within the first 7 days from the registration, makes these events as a sequence, and uses a convolutional layer to embed the event attributes as a vectors

The outputs of these two channels will be concatenated as an overall representation vector for the player's profile and activities and used it for the prediction of the churn.

## model training

The steps to build the model

1. data preprocessing [data_prepropessing.ipynb](data_prepropessing.ipynb)

2. feauture transformation [data_transform.ipynb](data_transform.ipynb)

3. parameter tunning over the training set with 4-fold cross-validation [cross_validation_parameter_tunning.ipynb](cross_validation_parameter_tunning.ipynb)

4. model training over the training set and evaluation over the test set [model_training_and_evaluation.ipynb](model_training_and_evaluation.ipynb)

The main pipeline entery code is at [main_pipeline.ipynb](main_pipeline.ipynb)

## results

result: over the test set 

* AUC: 0.8678, 
* ACC: 0.7969
