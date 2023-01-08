using Pkg 
Pkg.add("DataFrames")
# Pkg.add("ZipFile")
using DataFrames
# using InfoZIP
using ZipFile   
using PyCall
using CSV
# Pkg.add("Plots")
using Plots
# Pkg.add("StatsPlots"); 
using StatsPlots
using Statistics

url = "https://www.borsaistanbul.com/datum/PayEndeksleri.zip"
download(url, "PayEndeksleri.zip")

# unzip using python ZipFile
@pyimport zipfile

py"""
import zipfile
with zipfile.ZipFile("PayEndeksleri.zip", "r") as zip_ref:
    zip_ref.extractall("./outputs")
"""

df = CSV.read("outputs/FiyatEndeksleri_PriceIndices.csv", DataFrame)

first(df, 5)

# delete first row, which is not data
delete!(df, 1)

# rename columns to ORDER	INDEX CODE	INDEX NAMES IN TURKISH	INDICES	CURRENCY TYPE	DATE	CLOSING VALUE	OPEN VALUE	LOWEST VALUE	HIGHEST VALUE
df = rename(df, [:order, :index_code, :index_names_in_turkish, :indices, :currency_type, :date, :closing_value, :open_value, :lowest_value, :highest_value])

#remove index_names_in_turkish
df = select!(df, Not(:index_names_in_turkish))

# convert closing_value, open_value, lowest_value, highest_value to Float64
convert = [:closing_value, :open_value, :lowest_value, :highest_value]
for i in convert
    df[!, i] = parse.(Float64, df[!, i])
end


# calculate outliers

# calculate mean
br = mean(df.open_value)

# calculate standard deviation
aq = std(df.open_value)

# calculate cut-off
cut_off = aq * 3

# calculate lower and upper bound values

lower, upper = br - cut_off, br + cut_off

# identify outliers
outliers = filter(row -> row.open_value < lower || row.open_value > upper, df)

# remove outliers
df = filter(row -> row.open_value >= lower && row.open_value <= upper, df)


# put open_values into a boxplot, horizontal 


boxplot(df.open_value, title="Open Values", ylabel="Open Value", xlabel="Open Value", orientation=:horizontal)

