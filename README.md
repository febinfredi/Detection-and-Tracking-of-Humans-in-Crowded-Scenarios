## Detection and Tracking of humans in crowd scenarios

## Abstract
The main target of this project is to create and train a model to be able to detect humans in crowded scenarios. YOLOv4 model has been used for this task and was trained on CrowdHuman dataset which was specifically created for this purpose. Initial EDA was performed on the data and then YOLOv4 model was trained on this dataset and the evaluation was done by looking at accuracy, training loss and mAP scores. 

## Setup/Run

We use [CrowdHuman dataset](https://www.crowdhuman.org/) for training the model.

For initial EDA analysis, training and testing, I'm using Google Colab. Everything is put into a IPython Notebook. 
Steps: 
1. Create a copy of the IPython Notebook file.
2. Run all the cells. 

Note:

* Make sure to upload all the CrowdHuman dataset in your google drive and paste the dataset links in [prepare_training.sh](prepare_training.sh) file (line 40 - 47) as the drive link from the dataset authors doesn't work anymore.

* Make sure to change your runtime to GPU.

## Results:

Running model on a sample crowd video (Click on the image to watch the video): 
[<img src="https://img.youtube.com/vi/Jt7aZ-YmCno/maxresdefault.jpg" width="100%">](https://youtu.be/Jt7aZ-YmCno)
