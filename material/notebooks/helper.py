import numpy as np
import torch
import torch.nn as nn

def BCELoss(y_true, y_pred):
    y_pred = np.clip(y_pred, 1e-7, 1 - 1e-7)
    term_0 = (1-y_true) * np.log(1-y_pred + 1e-7)
    term_1 = y_true * np.log(y_pred + 1e-7)
    return -np.mean(term_0+term_1, axis=0)


def generate_data():
    np.random.seed(123)
    
    def make_cluster(means: list, samples=100):
        std_dev = [1] * len(means)  # Standard deviation for both dimensions

        # Generate 2D normally distributed data
        data = np.random.normal(means, std_dev, (samples, 2))
        return data

    x1 = make_cluster([2,2])
    y1 = np.array([0]*len(x1))
    x2 = make_cluster([-2,-2])
    y2 = np.array([1]*len(x2))

    X = np.concatenate((x1, x2))
    y = np.concatenate((y1, y2))
    
    # Generate random permutation of indices
    indices = np.random.permutation(len(X))

    # Shuffle both arrays using the same indices
    X = X[indices]
    y = y[indices]

    return X, y


# Define a simple one neuron NN
class SingleNeuronNN(nn.Module):
    def __init__(self):
        super(SingleNeuronNN, self).__init__()
        self.linear = nn.Linear(2, 1, bias=False)

    def forward(self, x):
        return torch.sigmoid(self.linear(x))
