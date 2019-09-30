# License-plate-recognition-neural-network
Using the given in the license plate image library () in the specified folder, select the number plate image, of which contains Numbers (0 ~ 9) or English character (A ~ F) manually extract, due to the extracted image size may not be consistent, to facilitate the feature extraction, can be normalized to the graphical processing (for example: one becomes size 10 x 20).  After processing, feature extraction can be carried out. Features can be either directly recognized by pixels in the above example program (this method often leads to large dimensions) or other feature extraction methods (for example, feature points corresponding to characters can be extracted according to their characteristics).  Characters are divided into two categories: training (at least 5 training samples for each character) and testing (10 tests can be selected for each character).By establishing a three-layer BP neural network for training, each parameter of the network is set by itself.After training, test the sample and calculate the accuracy of the test. 
