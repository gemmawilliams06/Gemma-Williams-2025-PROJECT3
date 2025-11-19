"""
TASK 1: Exploratory data of a single variable

Create several summaries and plots of the following variables: 
Rooms, Price, Method, Distance, and Landsize.
Make sure to choose appropriate diagram types as different types of data require different types of plots.
"""

#####################
#       Rooms       #
#####################
rooms_df = select(df, :Rooms)
filter!(row -> row.Rooms != 0, rooms_df)  # Remove rows where Rooms is 0 (missing)

summary_rooms = summarystats(rooms_df.Rooms)
println("Rooms summary statistics:")
println(summary_rooms)

histogram(rooms_df.Rooms, bins = minimum(rooms_df.Rooms)-0.5 : 1 : maximum(rooms_df.Rooms)+0.5,
    title = "Number of Rooms Density Histogram",
    xlabel = "Number of Rooms",
    ylabel = "Density",
    legend = false,
    normed = true)
savefig("task1_outputs/rooms_density_histogram.png")


#####################
#       Price       #
#####################
price_df = select(df, :Price)
filter!(row -> row.Price != 0, price_df)  # Remove rows where Price is 0 (missing)
sort!(price_df, :Price)

summary_price = summarystats(price_df.Price)
println("Price summary statistics:")
println(summary_price)

scatter(1:length(price_df.Price), price_df.Price,
    title = "House Prices Scatter Plot",
    xlabel = "Index",
    ylabel = "Price",
    legend = false)
savefig("task1_outputs/price_scatter_plot.png")

histogram(price_df.Price, bins = :auto,
    title = "Price Density Histogram",
    xlabel = "Price Brackets",
    ylabel = "Density",
    legend = false,
    normed = true)
density!(price_df.Price, lw=2, lc=:red)
savefig("task1_outputs/price_density_histogram.png")

# include cumulative density? already pretty clear from histogram

"""
Visual analysis:
- Some extreme outliers (very long tail to the right)
- Logarithmic transformation may be more appropriate for regression analysis (part 4)
""" 

#####################
#       Method     #
#####################
method_df = select(df, :Method)
# no filter needed as Method is qualitative and didn't have converted 0 values from missings

method_counts = combine(groupby(method_df, :Method), nrow => :Count)
println("Method counts:")
println(method_counts)

bar(method_counts.Method, method_counts.Count,
    title = "Sales Method Bar Plot",
    xlabel = "Method",
    ylabel = "Count",
    legend = false,
    xticks = (1:length(method_counts.Method), method_counts.Method),
    xrotation = 45)
savefig("task1_outputs/method_bar_plot.png")

"""
From data description:
S - property sold;
SP - property sold prior;
PI - property passed in;
PN - sold prior not disclosed;
SN - sold not disclosed;
NB - no bid;
VB - vendor bid;
W - withdrawn prior to auction;
SA - sold after auction;
SS - sold after auction price not disclosed.
N/A - price or highest bid not available.
"""

#####################
#      Distance     #
#####################
distance_df = select(df, :Distance)
filter!(row -> row.Distance != 0.0, distance_df)  # Remove rows where Distance is 0 (missing)
sort!(distance_df, :Distance)

summary_distance = summarystats(distance_df.Distance)
println("Distance summary statistics:")
println(summary_distance)

scatter(1:length(distance_df.Distance), distance_df.Distance,
    title = "Distance from CBD Scatter Plot",
    xlabel = "Index",
    ylabel = "Distance (km)",
    legend = false)
savefig("task1_outputs/distance_scatter_plot.png")

histogram(distance_df.Distance, bins = :auto,
    title = "Distance Density Histogram",
    xlabel = "Distance Brackets (km)",
    ylabel = "Density",
    legend = false,
    normed = true)
density!(distance_df.Distance, lw=2, lc=:red)
savefig("task1_outputs/distance_density_histogram.png")

"""
Visual analysis:
- Some extreme outliers (very long tail to the right)
- Logarithmic or polynomial transformation may be appropriate
"""

#####################
#      Landsize     #
#####################
landsize_df = select(df, :Landsize)
filter!(row -> row.Landsize != 0.0, landsize_df)  # Remove rows where Distance is 0 (missing)
sort!(landsize_df, :Landsize)

summary_landsize = summarystats(landsize_df.Landsize)
println("Landsize summary statistics (filtered):")
println(summary_landsize)

# Landsize has extremely large outliers making plots hard to read
# Filter out top 1% of landsize values for better visualisation
filter!(row -> row.Landsize <= quantile(landsize_df.Landsize, 0.99), landsize_df)

summary_landsize_filtered = summarystats(landsize_df.Landsize)
println("Landsize summary statistics (filtered):")
println(summary_landsize_filtered)

scatter(1:length(landsize_df.Landsize), landsize_df.Landsize,
    title = "Landsize Scatter Plot",
    xlabel = "Index",
    ylabel = "Landsize (sqm)",
    legend = false)
savefig("task1_outputs/landsize_scatter_plot.png")

histogram(landsize_df.Landsize, bins = :auto,
    title = "Landsize Density Histogram",
    xlabel = "Landsize Brackets (sqm)",
    ylabel = "Density",
    legend = false,
    normed = true)
density!(landsize_df.Landsize, lw=2, lc=:red)
savefig("task1_outputs/landsize_density_histogram.png")

"""
Visual analysis:
- Some extreme outliers making visual analysis difficult
Effects of filtering out top 1% of landsize values:
- 207 data points removed
- Mean decreased from 664 to 539
- Standard deviation decreased from 3588 to 323
- Maximum decreased from 433014 to 3414
- Plots are now readable

- Logarithmic or polynomial transformation may be appropriate
"""