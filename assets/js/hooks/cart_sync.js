/**
 * CartSync — attached to the cart and checkout pages.
 * On mount it reads localStorage and sends items to the LiveView.
 * Also handles item remove and quantity changes from the server.
 */
import Cart from "../cart.js";

const CartSync = {
  mounted() {
    // Send cart to LiveView immediately on mount
    this.pushEvent("cart_loaded", { items: Cart.getItems() });

    // Handle item removal triggered from LiveView
    this.handleEvent("remove-cart-item", ({ key }) => {
      Cart.removeItem(key);
      this.pushEvent("cart_loaded", { items: Cart.getItems() });
    });

    // Handle quantity update triggered from LiveView
    this.handleEvent("update-cart-quantity", ({ key, quantity }) => {
      Cart.updateQuantity(key, quantity);
      this.pushEvent("cart_loaded", { items: Cart.getItems() });
    });

    // Clear cart when server confirms successful order
    this.handleEvent("clear-cart", () => {
      Cart.clear();
    });
  },
};

export default CartSync;
