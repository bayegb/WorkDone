import torch
import torch.nn as nn
from torchvision import datasets
import matplotlib
matplotlib.use('TkAgg')
from matplotlib.pyplot import imshow
import matplotlib.pyplot as plt 
import numpy as np
import random
import torch.nn.functional as F
from PIL import Image
import torchvision.transforms as transforms


#Artifitial Neural Network
class ANN(nn.Module): 
    def __init__(self, input_size, num_classes, hidden_size=64):
        super(ANN, self).__init__()
        self.dropout = nn.Dropout(p=0.3)  # Add dropout with a rate of 30%
        self.hidden_layer = nn.Linear(input_size, hidden_size) 
        self.relu = nn.ReLU()   
        
       
    def forward(self, feature):
        # Compute hidden layer activations
        hidden_activations = self.hidden_layer(feature) # first layer/nodes of the hidden layer
        hidden_activations = self.dropout(hidden_activations)
        
        # Compute output layer logits - Hidden layer 
        output_logits1 = self.relu(hidden_activations)
        output_logits1 = self.dropout(output_logits1)
        
        output_logits2 = self.relu(output_logits1)
        output_logits2 = self.dropout(output_logits2)
        
        output_logits3 = self.relu(output_logits2)
        output_logits3 = self.dropout(output_logits3)
        
        #probabilty distribution (0-9)
        output_probs = torch.softmax(output_logits1, dim=1)
        
        return output_probs
    
def main():
    #DATA - Load MNIST from file
    DATA_DIR = "."
    download_dataset = False

    train_mnist = datasets.MNIST(DATA_DIR, train=True, download=download_dataset)
    test_mnist = datasets.MNIST(DATA_DIR, train=False, download=download_dataset)


    # Create variables for MNIST data   
    X_train = train_mnist.data.float()
    y_train = train_mnist.targets
    X_test = test_mnist.data.float()
    y_test = test_mnist.targets

    # Sample random indices for validation  
    test_size = X_test.shape[0]
    indices = np.random.choice(X_train.shape[0], test_size, replace=False)

    # Create validation set
    X_valid = X_train[indices]
    y_valid = y_train[indices]

    # Remove validation set from training set
    X_train = np.delete(X_train, indices, axis=0)
    y_train = np.delete(y_train, indices, axis=0)


    # reshape the data from matrices to vectors
    X_train = X_train.reshape(-1, 28*28)
    X_valid = X_valid.reshape(-1, 28*28)
    X_test = X_test.reshape(-1, 28*28)

    # Create data loaders/ batches
    batch_size = 64

    train_dataset = torch.utils.data.TensorDataset(X_train, y_train)
    val_dataset = torch.utils.data.TensorDataset(X_valid, y_valid)
    test_dataset = torch.utils.data.TensorDataset(X_test, y_test)

    train_loader = torch.utils.data.DataLoader(dataset=train_dataset, batch_size=batch_size, shuffle=True)
    val_loader = torch.utils.data.DataLoader(dataset=val_dataset, batch_size=batch_size, shuffle=False)
    test_loader = torch.utils.data.DataLoader(dataset=test_dataset, batch_size=batch_size, shuffle=False)
    
    #Train the model
    num_classes = 10  
    input_size = 28*28
    learning_rate = 0.0001
    model = ANN(input_size, num_classes)
    optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate) # can use AdamW  
    num_epochs = 100
    total_step = len(train_loader)

    for epoch in range(num_epochs):
        for i, (images, labels) in enumerate(train_loader):
            outputs = model(images)
            labels = labels.long()  # convert labels to long type
            loss = F.cross_entropy(outputs, labels)  # cross-entropy loss for multi-class
            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            if (i+1) % 100 == 0:
                print ('Epoch [{}/{}], Step [{}/{}], Loss: {:.4f}' 
                .format(epoch+1, num_epochs, i+1, total_step, loss.item()))
            
                # Compute validation accuracy
                model.eval()
                with torch.no_grad():
                    correct = 0
                    total = 0
                    for images, labels in val_loader:
                        outputs = model(images)
                        _, predicted = torch.max(outputs.data, 1)
                        total += labels.size(0)
                        correct += (predicted == labels).sum().item()
                    accuracy = 100 * correct / total

                print('Validation Accuracy: {} %'.format(accuracy))

    #Compute accuracy - Testing
    model.eval()
    with torch.no_grad():
        correct = 0
        total = 0
        for images, labels in test_loader:
            outputs = model(images)
            _, predicted = torch.max(outputs.data, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()

        print('Test Accuracy of the model on the 10000 test images: {} %'.format(100 * correct / total))

#Implement way of running the program 
#get user input as the path to the jpegs
#use the model to predict the jpg

    while True:
        file_path = input("Please enter a filepath or \"exit\" to exit:\n")

        if file_path == "exit":
            print("Exiting...")
            break
        else:
            img = Image.open(file_path)
            
            # Define a transform to convert the image to a Torch tensor
            transform = transforms.Compose([transforms.ToTensor()])

            # Convert the PIL image to a Torch tensor
            img_tensor = transform(img)
            img_tensor = img_tensor.reshape(-1, 28*28)

            #predict the given image's label
            output = model(torch.tensor(img_tensor).view(1, -1))
            _, predicted = torch.max(output, 1)
            print("Classifier: %d" % (predicted))

if __name__ == "__main__":
    main()

