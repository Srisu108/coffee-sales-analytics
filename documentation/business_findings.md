# Business Findings

## Overall Performance

- Total Sales: 45,134.26
- Total Profit: 4,520.22
- Units Sold: 3,551
- Orders: 957
- Average Order Value (AOV): 47.16
- Profit Margin: 10.01%

## Time Performance

- 2021 was the strongest complete year based on sales, profit and units sold.
- 2022 contains partial-year data through 19 August 2022 and should not be compared directly with complete years.

## Product Performance

### Coffee Type

- Arabica had the highest unit volume with 947 units sold.
- Excelsa generated the highest sales at approximately 12.3K.
- Liberica generated the highest profit at approximately 1.57K.
- Liberica also had the highest profit margin at approximately 13%.
- Robusta was the weakest performer, with the lowest sales and profit margin.

### Roast Type

- Light roast generated the highest sales and profit.
- Dark roast had the highest profit margin at approximately 10.17%.

### Size

- 2.5 size generated the highest sales and profit.
- 0.5 size had the highest unit volume.
- Profit margins were relatively consistent across sizes at around 10%.

## Customer and Loyalty Analysis

- Customers without a loyalty card generated slightly higher total sales, profit and order volume.
- Average orders per customer were approximately 1.05 for both loyalty groups.
- Profit margins were almost identical between loyalty and non-loyalty customers.
- The analysis does not establish that loyalty membership causes higher or lower performance.

## Key Business Takeaways

1. Overall profitability is approximately 10%.
2. Arabica leads in volume, while Excelsa leads sales and Liberica leads profitability.
3. Robusta requires further investigation due to its weaker profitability.
4. Light roast contributes the highest sales and profit.
5. The 2.5 size is the strongest revenue and profit contributor.
6. Loyalty membership does not show a meaningful difference in average orders per customer in this dataset.
7. Product mix appears to have a stronger relationship with profitability than loyalty status.

## Analytical Considerations

- The orders table is stored at order-line grain rather than one row per order.
- Order counts therefore use `DISTINCT order_id`.
- 2022 is an incomplete year and should be treated accordingly.
- Missing customer email values were retained rather than artificially populated.
- Total Profit is calculated using the product-level profit value multiplied by quantity.