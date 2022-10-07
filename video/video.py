import imageio
import glob
import os

path = "C:/Users/Rokas/OneDrive/Desktop/simulation/images/"

fileList = []
for file in os.listdir(path):
    if file.startswith("water_height_"):
        complete_path = path + file
        fileList.append(complete_path)

writer = imageio.get_writer('test.mp4', fps=40)

for im in fileList:
    writer.append_data(imageio.imread(im))
writer.close()
