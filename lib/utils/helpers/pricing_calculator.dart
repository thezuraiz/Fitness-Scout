class ZPricingCalculator{

  // --- CALCULATE PRICE BASED ON TAX AND SHIPPING
  static double calculateTotalPrice(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  // CALCULATE SHIPPING COST
  static String calculateShippingCost(double productPrice, String location){
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  // CALCULATE TAX
  static String calculateTax(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location){
    // LookUp he shipping tax for the given location using shipping Rate API
    // Calculate shipping tax based on the various factors like distance, weight etc.
    return 0.10;
  }

  static double getShippingCost(String location){
    // LookUp he shipping cost for the given location using shipping Rate API
    // Calculate shipping cost based on the various factors like distance, weight etc.
    return 5.00;
  }

}