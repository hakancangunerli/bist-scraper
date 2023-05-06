# %%
import urllib
import zipfile 
import pandas as pd


url = 'https://www.borsaistanbul.com/datum/PayEndeksleri.zip'

urllib.request.urlretrieve(url,"pay.zip")
# unzip the zip 


# %%
# unzip the pay.zip
with zipfile.ZipFile('./pay.zip', 'r') as zip_ref:
    zip_ref.extractall('./outputs')

# %%
df = pd.read_csv('./outputs/FiyatEndeksleri_PriceIndices.csv', sep=';')

# %%
df.head(5)

# %%
df= df.filter(['ENDEKS KODU','ACILIS', 'KAPANIS', 'EN YUKSEK', 'EN DUSUK'])
df= df.drop([0])

# %%
import plotly.express as px
fig = px.box(df,x='ACILIS')
fig.show()



# %%
df.head(5)


# %%
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np 

# %%
df['ACILIS'] = df['ACILIS'].astype(float)

x = df['ACILIS'].to_numpy()

# %%
x

# %%
plt.boxplot(x, vert=False)
plt.xlim([0,10000])


