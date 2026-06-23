class APIconst {
  static String baseUrl = 'https://thimar.amr.aait-d.com/public/api';
  static const verify = 'verify';
  static const passwordVerify = 'check_code';
  static const resend = 'resend_code';
  static const forgetPassword = 'forget_password';
  static const login = 'login';
  static const register = 'client_register';
  static const resetPassword = 'reset_password';
  static const sliders = 'sliders';
  static const profile = 'client/profile';
  static const faqs = 'faqs';
  static const contact = 'contact';
  static const about = 'about';
  static const editProfile = 'client/profile';
  static const logout = 'logout';
  static const policy = 'policy';
  static const terms = 'terms';
  static const categories = 'categories';
  static const getFavorites = 'client/products/favorites';
  static String addToFavorite(String id) => 'client/products/$id/add_to_favorite';
  static String removeFromFavorite(String id) => 'client/products/$id/remove_from_favorite';
  
  static const products = 'products';
  static String productDetails(String id) => 'products/$id';
  static String productRates(String id) => 'products/$id/rates';
  static String categoryProducts(String id) => 'categories/$id';
  static const cart = 'client/cart';
  static String updateCartItem(String id) => 'client/cart/$id';
  static String deleteCartItem(String id) => 'client/cart/delete_item/$id';
  static const addresses = 'client/addresses';
  static String deleteAddress(String id) => 'client/addresses/$id';
  static String updateAddress(String id) => 'client/addresses/$id';
  
  static const wallet = 'wallet';
  static const chargeWallet = 'wallet/charge';
  static const notifications = 'notifications';
}
