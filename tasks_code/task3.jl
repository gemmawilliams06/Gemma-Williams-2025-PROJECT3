"""
TASK 3: Exploratory data analysis over time
Create several plots that visualise trends in the data over time.
Specifically ploit the total transaction amount, number of sales, and the fraction of sales which were houses.
You may aggregate the values into months.
"""

"""
List of graphs to create:
- Total transaction amount over time
  - line plot
- Number of sales over time
  - line plot
- Fraction of sales which were houses over time
  - line plot

- Proportion of average house price based on year built over time
"""

# First group by year and months
time_df = groupby(df, [:Year, :Month])

##########################################
#   Total transaction amount over time   #
##########################################
transaction_amt_over_time = combine(time_df, :Price => sum => :Total_Transaction_Amount)
transform!(transaction_amt_over_time, [:Year, :Month] => ByRow((y,m) -> string(m) * "/" * string(y)) => :Period)

sort!(transaction_amt_over_time, [:Year, :Month])
scatter(transaction_amt_over_time.Period, transaction_amt_over_time.Total_Transaction_Amount,
    title = "Total Transaction Amount Over Time",
    xlabel = "Time (mm/yyyy)",
    ylabel = "Total Transaction Amount (Aggregated Monthly)",
    legend = false)
savefig("task3_outputs/total_transaction_amount_over_time.png")

#################################
#   Number of Sales over Time   #
#################################
num_sales = combine(time_df, nrow => :Number_of_Sales)
transform!(num_sales, [:Year, :Month] => ByRow((y,m) -> string(m) * "/" * string(y)) => :Period)
sort!(num_sales, [:Year, :Month])
scatter(num_sales.Period, num_sales.Number_of_Sales,
    title = "Number of Sales Over Time",
    xlabel = "Time (mm/yyyy)",
    ylabel = "Number of Sales (Aggregated Monthly)",
    legend = false)
savefig("task3_outputs/number_of_sales_over_time.png")


######################
#   Sales per Type   #
######################
sales_by_type = combine(time_df, :Type => (x -> sum(x .== "h")) => :House_Sales,
                                      :Type => (x -> sum(x .!= "h")) => :Non_House_Sales)
transform!(sales_by_type, [:Year, :Month] => ByRow((y,m) -> string(m) * "/" * string(y)) => :Period)
sort!(sales_by_type, [:Year, :Month])

# Fraction of sales that were houses over time
sales_by_type.Fraction_Houses = sales_by_type.House_Sales ./ (sales_by_type.House_Sales .+ sales_by_type.Non_House_Sales)
scatter(sales_by_type.Period, sales_by_type.Fraction_Houses,
    title = "Fraction of Sales that were Houses Over Time",
    xlabel = "Time (mm/yyyy)",
    ylabel = "Fraction of Sales that were Houses",
    legend = false)
savefig("task3_outputs/fraction_of_houses_over_time.png")

# Fraction of sales per type over time
scatter(sales_by_type.Period, sales_by_type.House_Sales,
    label = "House Sales",
    title = "Number of Sales by Type Over Time",
    xlabel = "Time (mm/yyyy)",
    ylabel = "Number of Sales (Aggregated Monthly)")
scatter!(sales_by_type.Period, sales_by_type.Non_House_Sales,
    label = "Non-House Sales")
savefig("task3_outputs/number_of_sales_by_type_over_time.png") 