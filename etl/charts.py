import matplotlib.pyplot as plt
import os

def bar_chart(df, x,y, filename):
    os.makedirs("output", exist_ok=True)

    plt.figure()
    df.groupby(x)[y].sum().plot(kind="bar")
    plt.title(f"{y} by {x}")
    plt.savefig(f"output/{filename}")
    plt.close()

def pie_chart(df, column, filename):
    plt.figure()
    df[column].value_counts().plot(kind="pie", autopct='%1.1f%%')
    plt.ylabel(" ")
    plt.savefig(f"output/{filename}")
    plt.close()

