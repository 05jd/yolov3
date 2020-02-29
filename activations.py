import torch
import torch.nn as nn
import torch.nn.functional as F


def lrelu(x, negative_slope, m):
    s = x - torch.floor(m * x) / m
    g = torch.zeros_like(x)
    g[x < 0] = negative_slope
    return F.leaky_relu(x, negative_slope=negative_slope) + s * g


class LReLU(nn.Module):

    def __init__(self, negative_slope=1e-2, m=1e5):
        super().__init__()
        self.negative_slope = negative_slope
        self.m = m

    def forward(self, x):
        return lrelu(x, negative_slope=self.negative_slope, m=self.m)


def test():
    x = torch.tensor([-1.03, 2.01, 3.02, -3.04])
    l = lrelu(x, negative_slope=0.1, m=1e1)
    print(l)


if __name__ == '__main__':
    test()
