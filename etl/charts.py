import matplotlib.pyplot as plt
import os
# import pandas as pd

def bar_chart(df, x,y, filename):

    os.makedirs("output", exist_ok=True)
   # path = f"output/{filename}"

    plt.figure()
    df.groupby(x)[y].sum().plot(kind="bar")
    #result.plot(kind="bar")
    plt.title(f"{y} by {x}")
    plt.tight_layout()
    plt.savefig(f"output/{filename}")
    plt.close()

def pie_chart(df, column, filename):
    os.makedirs("output", exist_ok= True)
  #  path = f"output/{filename}"

    plt.figure()
    df[column].value_counts().plot(kind="pie", autopct="%1.1f%%")
    plt.ylabel(" ")
    plt.tight_layout()
    plt.savefig(f"output/{filename}")
    plt.close()