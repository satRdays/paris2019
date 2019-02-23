
library(keras)


########################################################################
## ----data mnist--------------
########################################################################

#loading the keras inbuilt mnist dataset
data <- dataset_mnist()

#separating train and test file
train_x <- data$train$x
train_y <- data$train$y
test_x <- data$test$x
test_y <- data$test$y
 

# converting a 2D array into a 1D array for feeding into the MLP and normalising the matrix
train_x <- array(train_x, dim = c(dim(train_x)[1], prod(dim(train_x)[-1]))) / 255
test_x <- array(test_x, dim = c(dim(test_x)[1], prod(dim(test_x)[-1]))) / 255

image(matrix(train_x[2,],28,28,byrow = T), axes = FALSE,col = gray.colors(255))

#converting the target variable to once hot encoded vectors using keras inbuilt function
train_y_cat <- to_categorical(train_y,10)
test_y_cat <- to_categorical(test_y,10)
train_y <- train_y_cat
test_y <- test_y_cat


########################################################################
## ----mnist network  initialisation                   -----------------
########################################################################
model <- keras_model_sequential()

########################################################################
## ----mnist networkdefinition, eval =TRUE---------------------------------
########################################################################

model %>% 
layer_dense(units = 784, input_shape = 784) %>% 
layer_dropout(rate = 0.4) %>% 
layer_activation(activation = 'relu') %>% 
layer_dense(units = 10) %>% 
layer_activation(activation = 'softmax')


model %>% compile(
loss = 'categorical_crossentropy',
optimizer = 'adam', 
metrics = c('accuracy')
)

########################################################################
## ----learning ------------------------------------------------
########################################################################

learning_history <- model %>% fit(train_x, train_y, epochs = 10, batch_size = 1000)

## ----learning again ------------------------------------------
learning_history <- model %>% fit(train_x, train_y, epochs = 10, batch_size = 1000)


## ----testing,  ------------------------------------------------
predictions <- model %>% predict_classes(test_x)
table(predictions,test_y %*% matrix(0:9,ncol = 1))
mean(predictions == c(test_y %*% matrix(0:9,ncol = 1))) * 100

predictions_proba <- model %>% predict_proba(test_x)
loss_and_metrics <- model %>% evaluate(test_x, test_y, batch_size = 128)

## ----output--------------------------------------------------------------
summary(model)
plot(learning_history)

## ----saving and loading keras object-------------------------------------
save_model_hdf5(model, "NN_mnist.h5")




##################################################################
###########" Convolutional NN -> for people with an efficient machine !!!!
##################################################################


## ----transfo data image--------------------------------------------------
d <- dim(data$train$x)
train_x_picture <- array(0,c(d,1)) 
train_x_picture[,,,1] <- data$train$x/255

## ----def CNN-------------------------------------------------------------
model_convol <- keras_model_sequential()
model_convol %>%
  layer_conv_2d(filters = 64, kernel_size = c(3,3), use_bias = TRUE, activation = 'relu',data_format = 'channels_last') %>%
  layer_max_pooling_2d(pool_size = c(2, 2)) %>%
  layer_dropout(0.2) %>%
  layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = 'relu') %>%
  layer_flatten() %>%
  layer_dense(units = 10) %>% 
  layer_activation(activation = 'softmax')

model_convol %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = 'adam', 
  metrics = c('accuracy')
)

## ----fit CNN-------------------------------------------------------------
learning_history_convol <- model_convol %>% fit(train_x_picture, train_y, validation_split = 0.1, epochs = 10, batch_size = 5000)

 

## ----output CNN----------------------------------------------------------
summary(model_convol)
plot(learning_history_convol)



##########################################################################
## ----iris----------------------------------------------------------------
###########################################################################"
data(iris)
library(tidyverse)
x_iris <- 
  iris %>% 
  select(-Species) %>% 
  as.matrix %>% 
  scale 
library(keras)
y_iris <- to_categorical(as.integer(iris$Species)-1)

## ----stratified_train_test_splitting-------------------------------------
set.seed(0)
ntest <- 15 # number of test samples in each class
test.index <-
  tibble(row_number =1:nrow(iris),Species = iris$Species)  %>% group_by(Species) %>% sample_n(ntest) %>% pull(row_number)
train.index <- (1:nrow(iris))[-test.index]

x_iris_train <- x_iris[train.index,]
y_iris_train <- y_iris[train.index,]
x_iris_test <- x_iris[test.index,]
y_iris_test <- y_iris[test.index,]

## ---- eval=FALSE---------------------------------------------------------
model_iris <- keras_model_sequential()
model_iris %>%
layer_dense(units = 4, input_shape = 4) %>%
layer_dropout(rate = 0.1) %>%
layer_activation(activation = 'relu') %>%
layer_dense(units = 3) %>%
layer_activation(activation = 'softmax')

model_iris %>% compile(
loss = 'categorical_crossentropy',
optimizer = 'adam',
metrics = c('accuracy')
)
learning_history <- model_iris %>% fit(x_iris_train, y_iris_train, epochs = 200, validation_split=0.0)## loss_and_metrics <- model %>% evaluate(x_iris_test, y_iris_test)

estimation <- apply(predict(model_iris,x_iris_test),1,which.max)
truth <- apply(y_iris_test,1,which.max)
table(estimation, truth)

##########################################################################
## ----model autoencoder  -------------------------------
###########################################################################"

model_autoencoder <- keras_model_sequential()

model_autoencoder %>%
  layer_dense(units = 2, activation = 'linear',input_shape = ncol(x_iris),name = "inter_layer") %>%
 layer_dense(units = 4, activation = 'linear')

model_autoencoder %>% compile(
     loss = 'mse',
     optimizer = 'adam',
     metrics = 'mse'
 )

model_autoencoder %>% fit(
     x_iris_train,
     x_iris_train,
     epochs = 1000,
  batch_size = 16,
  shuffle  = TRUE,
    validation_split = 0.1,
)
model_projection = keras_model(inputs = model_autoencoder$input, outputs = get_layer(model_autoencoder,"inter_layer")$output)
## 
intermediate_output = predict(model_projection,x_iris_train)
## 
## 

## ---- eval = FALSE-------------------------------------------------------
library(FactoMineR)
res.pca <- PCA(x_iris_train, graph = FALSE)

par(mfrow=c(1,2))
plot(intermediate_output[,1],intermediate_output[,2],col = y_iris_train %*% (1:3))
plot(res.pca$ind$coord[,1],res.pca$ind$coord[,2], col = y_iris_train %*% (1:3))
## 


