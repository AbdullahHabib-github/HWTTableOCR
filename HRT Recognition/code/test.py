import cv2
import pandas as pd
import numpy as np
from path import Path
from main import infer
from model import Model
from tablebreaker import pre_processing



custom_name = "1.jpg"
model = Model( must_restore=True)

####breaking down table into little images for each cell
img = cv2.imread("C:/Users/abdul/OneDrive/Desktop/Table OCR/Implementation code/HRT Recognition/code/" + custom_name)
try:
    x,y=pre_processing(img)
except:
    print ("Invalid table")
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