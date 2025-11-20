"""
Loads the housing data into required DataFrames
Makes necessary initial transformations for analysis
"""

using DataFrames, CSV, StatsBase, StatsPlots, Plots, GLM, Underscores

open("data/Melbourne_housing_FULL.csv")

df = CSV.read("data/Melbourne_housing_FULL.csv", DataFrame; missingstring="NA");

# Extract Year from Date
transform!(df, :Date => ByRow(x -> x[end-3:end]) => :Year);
transform!(df, :Date => ByRow(x -> x != "" ? parse(Int, split(x, "/")[2]) : 0) => :Month)

# Convert necessary columns to Int
# Handle missing values as 0

function int_or_nan(x)
    return x != "" ? parse(Int, x) : 0
end

function float_or_nan(x)
    return x != "" ? parse(Float64, x) : 0.0
end

transform!(df, 
    :Price => ByRow(int_or_nan) => :Price,
    :Year => ByRow(int_or_nan) => :Year,
    :Distance => ByRow(float_or_nan) => :Distance,
    :Bedroom2 => ByRow(int_or_nan) => :Bedroom2,
    :Bathroom => ByRow(int_or_nan) => :Bathroom,
    :Car => ByRow(int_or_nan) => :Car,
    :Landsize => ByRow(int_or_nan) => :Landsize,
    :BuildingArea => ByRow(float_or_nan) => :BuildingArea,
    :YearBuilt => ByRow(int_or_nan) => :YearBuilt,
    :Lattitude => ByRow(float_or_nan) => :Latitude,
    :Longtitude => ByRow(float_or_nan) => :Longitude,
    :Propertycount => ByRow(int_or_nan) => :Propertycount);

# Convert Price to millions for easier visualisation
transform!(df, :Price => ByRow(x -> x / 1000000) => :Price);

# Add a column for the age of the house when sold
transform!(df, [:Year, :YearBuilt] => ByRow((y, yb) -> (y > 0 && yb > 0 && y >= yb) ? y - yb : 0) => :Age)