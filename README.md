# HWT Table OCR
## Description
This repository contains the code and model for a mobile app that scans handwritten tables and converts them into a CSV file. The app utilizes deep learning techniques to recognize and extract table data from handwritten documents, providing a convenient and efficient way to digitize handwritten tables.

## Features
* Scan handwritten tables: The app allows users to capture images of handwritten tables using their mobile devices.
*  Table recognition: Utilizing a pre-trained machine learning model, the app recognizes and extracts table data from the captured images.
* Data extraction: The app converts the recognized table data into a structured CSV format.
* User-friendly interface: The app provides a user-friendly interface that guides users through the scanning and conversion process.
## Installation
Clone the repository to your local machine.
Ensure that you have the required dependencies installed. (Please refer to the requirments.txt in the HTR Recognition folder)
## Mobile App
- The app was created using Flutter.
- To avoid complexities I uploaded only the important files to use and run the mobile app.
* To use the mobile app, download the <code>main.dart</code> and the <code>workder.dart</code> from the Mobile_app folder and place them in the <code>lib</code> folder of your flutter app
* To look for dependencies, please refer to the <code>pubsec.yaml</code> file in the Mobile_app folder.

## Working (APP)
The front end was developed using Flutter and Flask was used for the back end support. During the debugging phase, the flutter app was used to upload the image of the server. Then on the Server end, I had Flask script running, waiting for the image to be received.
Once the Flask server receives the Image of the HandWritten Table, it performs further processing and generates a CSV file.

![Screenshot 2023-05-16 205212](https://github.com/AbdullahHabib-github/HWTTableOCR/assets/91840456/8d519dea-204d-4786-b051-1d2c7200a348)

## Working (Backend)
Once the Flask script recieves the image, it breaks down the image into little images, each of these images representing a cell of the table. This process was done using the [Preprocessing script](HRT%20Recognition/code/preprocessor.py). Then each of these images is processed using the Handwritten Text recognition model and a resultant word is generated for each cells.
At the end, each of these words are combined in a Pandas <code>DataFrame</code> and a CSV file is generated.

## Working (Model)
The model training files were taken from the [SimpleHTR](https://github.com/githubharald/SimpleHTR) repository. This Repository allows you to train files using 3 different algorithms. I trained my models on each one of them and have uploaded the model files generated through all 3 algorithm. (you can find them in the HRT Recognition folder).
I did a detailed compariso. Please find the comparison graphs at the end of the <code>README.md</code> file.

## Research Report
Please find the Research Report at the following link:
https://www.overleaf.com/read/qvxgnbqccdsj
## Comparison
Please find the comparison below:

### Word Accuracy Comparison
In this case, Word Beam Search decoder works the best , you can find this [here](https://github.com/githubharald/CTCWordBeamSearch)
![Word_Accuracy](https://github.com/AbdullahHabib-github/HWTTableOCR/assets/91840456/6eeeed7e-5fab-4f43-aabd-6b1df8722e0c)


### Average Train Loss Comparison
Here, [Word Beam Search decoder](https://github.com/githubharald/CTCWordBeamSearch) works the best and the rest are almost the same. 
![Avg_Train_Loss](https://github.com/AbdullahHabib-github/HWTTableOCR/assets/91840456/0d790f8a-1696-4582-9f6d-3a83f0788557)


### Character Error Rate Comparison
[Word Beam Search decoder](https://github.com/githubharald/CTCWordBeamSearch) is proven to be the best in this case too and the rest are almost the same. 
![Chr_Err_Rate](https://github.com/AbdullahHabib-github/HWTTableOCR/assets/91840456/795d37ba-7c95-4a71-834b-b9185408936a)


