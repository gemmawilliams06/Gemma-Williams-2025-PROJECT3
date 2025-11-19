"""
TASK 2: Exploratory data analysis Comparing variables
Create several plots that present the house price as a function of
one or more other variables in the dataset.
Visually search for relationships between variables.
"""

"""
Assume no transformations to be applied yet
"""

############################
#      Price vs Rooms      #
############################

# Scatterplot of Avg Price vs Rooms
rooms_df = groupby(df, :Rooms)
price_by_rooms = combine(rooms_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_rooms, :Rooms)
scatter(price_by_rooms.Rooms, price_by_rooms.Avg_Price,
    title = "Average Price by Number of Rooms Scatter Plot",
    xlabel = "Number of Rooms",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_rooms_scatter.png")


# Scatterplot of Avg Price vs Rooms, grouped by Type
rooms_type_df = groupby(df, [:Rooms, :Type])
price_by_rooms_type = combine(groupby(df, [:Rooms, :Type]), :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_rooms_type, [:Type, :Rooms])
scatter(price_by_rooms_type.Rooms, price_by_rooms_type.Avg_Price,
    group = price_by_rooms_type.Type,
    title = "Average Price by Number of Rooms & House Type",
    xlabel = "Number of Rooms",
    ylabel = "Average Price (AUD)",
    legend = true,
    markersize = 4)
savefig("task2_outputs/price_by_rooms_by_type_scatter.png")


############################
#      Price vs Type       #
############################
type_df = groupby(df, :Type)
price_by_type = combine(type_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_type, :Type)
scatter(price_by_type.Type, price_by_type.Avg_Price,
    title = "Average Price by Type Scatter Plot",
    xlabel = "Type",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_type_scatter.png")

############################
#      Price vs Type       #
############################
distance_df = groupby(df, :Distance)
price_by_distance = combine(distance_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_distance, :Distance)
scatter(price_by_distance.Distance, price_by_distance.Avg_Price,
    title = "Average Price by Distance Scatter Plot",
    xlabel = "Distance from CBD (km)",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_distance_scatter.png")


############################
#      Price vs Suburb     #
############################
suburbs_df = groupby(df, :Suburb)
price_by_suburb = combine(suburbs_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_suburb, :Suburb)

# Top 20 suburbs by average price
top20_suburbs = first(sort(price_by_suburb, :Avg_Price, rev=true), 20)
scatter(top20_suburbs.Suburb, top20_suburbs.Avg_Price,
    title = "Top 20 Suburbs by Average Price Scatter Plot",
    xlabel = "Suburb",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4,
    xticks = (1:20, top20_suburbs.Suburb),
    xrotation = 45)
savefig("task2_outputs/price_by_suburb(top20)_scatter.png")

# Bottom 20 suburbs by average price
bottom20_suburbs = first(sort(price_by_suburb, :Avg_Price, rev=false), 20)
scatter(bottom20_suburbs.Suburb, bottom20_suburbs.Avg_Price,
    title = "Bottom 20 Suburbs by Average Price Scatter Plot",
    xlabel = "Suburb",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4,
    xticks = (1:20, bottom20_suburbs.Suburb),
    xrotation = 45)
savefig("task2_outputs/price_by_suburb(bottom20)_scatter.png")

############################
#    Price vs Bedrooms     #
############################
bedroom_df = groupby(df, :Bedroom2)
price_by_bedroom = combine(bedroom_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_bedroom, :Bedroom2) 
scatter(price_by_bedroom.Bedroom2, price_by_bedroom.Avg_Price,
    title = "Average Price by Number of Bedrooms Scatter Plot",
    xlabel = "Number of Bedrooms",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_bedroom_scatter.png")

#############################
#    Price vs Bathrooms     #
#############################
bathroom_df = groupby(df, :Bathroom)
price_by_bathroom = combine(bathroom_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_bathroom, :Bathroom)
scatter(price_by_bathroom.Bathroom, price_by_bathroom.Avg_Price,
    title = "Average Price by Number of Bathrooms Scatter Plot",
    xlabel = "Number of Bathrooms",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_bathroom_scatter.png")

############################
#      Price vs Car        #
############################
car_df = groupby(df, :Car)
price_by_car = combine(car_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_car, :Car)
scatter(price_by_car.Car, price_by_car.Avg_Price,
    title = "Average Price by Number of Car Spaces Scatter Plot",
    xlabel = "Number of Car Spaces",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_car_scatter.png")

############################
#    Price vs Landsize     #
############################
landsize_df = groupby(df, :Landsize)
price_by_landsize = combine(landsize_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_landsize, :Landsize)
# Landsize has extremely large outliers making plots hard to read
# Filter out top 1% of landsize values for better visualisation
filter!(row -> row.Landsize <= quantile(price_by_landsize.Landsize, 0.99), price_by_landsize)

scatter(price_by_landsize.Landsize, price_by_landsize.Avg_Price,
    title = "Average Price by Landsize Scatter Plot",
    xlabel = "Landsize (sqm) (Excluding Top 1%)",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_landsize_scatter.png")

############################
#    Price vs YearBuilt    #
############################
yearbuilt_df = groupby(df, :YearBuilt)
price_by_yearbuilt = combine(yearbuilt_df, :Price => mean ∘ skipmissing => :Avg_Price)
sort!(price_by_yearbuilt, :YearBuilt)
scatter(price_by_yearbuilt.YearBuilt, price_by_yearbuilt.Avg_Price,
    title = "Average Price by Year Built Scatter Plot",
    xlabel = "Year Built",
    ylabel = "Average Price (AUD)",
    legend = false,
    markersize = 4)
savefig("task2_outputs/price_by_yearbuilt_scatter.png")