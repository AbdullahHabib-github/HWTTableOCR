from flask import Flask, request, jsonify
import cv2
import pandas as pd
import numpy as np
from path import Path
from main import infer
from model import Model
from tablebreaker import pre_processing
import werkzeug

# import cv2
app = Flask(__name__)
# video = cv2.VideoCapture(0)
@app.route('/')
def index():
    return "Default Message"


@app.route('/scan', methods = ['POST','GET'])
def scan():
    if request.method == 'POST':
        #Recieving files from the device
        imagefile = request.files['image']
        custom_name = 'check.jpg'  # replace this with your desired name and file extension
        imagefile.save("C:/Users/abdul/OneDrive/Desktop/Table OCR/Implementation code/HRT Recognition/code/" + custom_name)
        

        model = Model( must_restore=True)

####breaking down table into little images for each cell
        img = cv2.imread("C:/Users/abdul/OneDrive/Desktop/Table OCR/Implementation code/HRT Recognition/code/" + custom_name)
        try:
            x,y=pre_processing(img)
        except:
            print ("Invalid table")
            return jsonify({"message":"Invalid table"})
        table_list=[]
        for i in range(x*y):
             try:
                table_list.append(infer(model, Path('C:/Users/abdul/OneDrive/Desktop/TableApp/ModelFIles/src/{}.png'.format(i)))[0])
             except:
                table_list.append("Invalid")
####combining results from each image to a dataframe
        arr=np.array(table_list)
        arr = arr.reshape(y, x)
        df = pd.DataFrame(arr)
        df.to_excel("output.xlsx")
        msg = "Excel File Generated Successfully"
        print(msg)
    return jsonify({"message":"Excel File Generated Successfully"})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)