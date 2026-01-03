import React, { useState } from 'react';
import { MapPin, Phone, Home, CreditCard, Map, Clock, ChevronLeft, Plus, Minus, Check, Truck, Package, Navigation, AlertCircle, CheckCircle, User, Calendar, IndianRupee } from 'lucide-react';

// Main App Component
export default function NammaRationApp() {
  const [currentScreen, setCurrentScreen] = useState('shop-details');
  const [selectedItems, setSelectedItems] = useState({
    rice: 1,
    sugar: 0,
    cookingOil: 1,
    wheat: 0
  });
  const [selectedDate, setSelectedDate] = useState('today');
  const [selectedSlot, setSelectedSlot] = useState(null);
  const [bookingConfirmed, setBookingConfirmed] = useState(false);
  const [tokenNumber, setTokenNumber] = useState('A-142');
  
  // Delivery-specific state
  const [deliveryMode, setDeliveryMode] = useState(null); // 'pickup' or 'delivery'
  const [deliveryEligibility, setDeliveryEligibility] = useState(null);
  const [deliveryAddress, setDeliveryAddress] = useState({
    line1: '24, Lakshmi Street',
    line2: 'Anna Nagar West Extension',
    city: 'Chennai',
    pincode: '600101',
    landmark: 'Near Corporation Primary School',
    phone: '+91 98765 43210'
  });
  const [selectedDeliveryDate, setSelectedDeliveryDate] = useState(null);
  const [selectedDeliverySlot, setSelectedDeliverySlot] = useState(null);
  const [deliveryConfirmed, setDeliveryConfirmed] = useState(false);
  const [deliveryOrderId, setDeliveryOrderId] = useState('DL-2025-0142');

  const shopDetails = {
    name: 'Shop #402, Anna Nagar',
    location: 'Anna Nagar West Extension, Chennai - 600101',
    distance: '0.2 km away'
  };

  const userCard = {
    cardNumber: '01/G/0123456',
    cardType: 'Priority Household (PHH)',
    headOfFamily: 'Smt. Lakshmi Sundaram',
    age: 68,
    shop: 'Shop #402, Anna Nagar',
    entitlements: {
      rice: 20,
      sugar: 2,
      cookingOil: 2,
      wheat: 5
    }
  };

  const timeSlots = [
    { time: '08:00 AM - 09:00 AM', status: 'vacant', count: 12 },
    { time: '09:00 AM - 10:00 AM', status: 'vacant', count: 8 },
    { time: '10:00 AM - 11:00 AM', status: 'filling', count: 3 },
    { time: '11:00 AM - 12:00 PM', status: 'filling', count: 2 },
    { time: '12:00 PM - 01:00 PM', status: 'full', count: 0 }
  ];

  const deliveryDates = [
    { date: 'Sat, Jan 4', available: true, routeId: 'ANW-01', deliveries: 12 },
    { date: 'Sun, Jan 5', available: true, routeId: 'ANW-01', deliveries: 8 },
    { date: 'Sat, Jan 11', available: true, routeId: 'ANW-01', deliveries: 15 },
    { date: 'Sun, Jan 12', available: false, routeId: 'ANW-01', deliveries: 30 }
  ];

  const deliveryTimeSlots = [
    { time: '09:00 AM - 01:00 PM', label: 'Morning Slot', available: true },
    { time: '02:00 PM - 06:00 PM', label: 'Afternoon Slot', available: true }
  ];

  const nearbyShops = [
    { id: 1, name: 'Shop #402, Anna Nagar', address: 'Anna Nagar West Extension, Chennai - 600101', distance: '0.2 km', registered: true },
    { id: 2, name: 'Shop #405, Aminjikarai', address: 'Aminjikarai Main Road, Chennai - 600029', distance: '1.2 km', registered: false },
    { id: 3, name: 'Shop #410, Kilpauk', address: 'Kilpauk Garden Road, Chennai - 600010', distance: '2.5 km', registered: false }
  ];

  const itemPrices = {
    rice: 0,
    sugar: 25,
    cookingOil: 100,
    wheat: 0
  };

  const calculateTotal = () => {
    return Object.keys(selectedItems).reduce((total, item) => {
      return total + (selectedItems[item] * itemPrices[item]);
    }, 0);
  };

  const calculateDeliveryFee = () => {
    // Free for seniors 70+, differently-abled
    if (userCard.age >= 70 || deliveryEligibility === 'eligible') return 0;
    // Nominal fee for others
    return 25;
  };

  // Screen Components
  const ShopDetailsScreen = () => (
    <div className="screen">
      <div className="header">
        <div>
          <div className="header-title">Your Shop / உங்கள் கடை</div>
          <div className="shop-name">{shopDetails.name}</div>
        </div>
        <CreditCard className="header-icon" />
      </div>

      <div className="content">
        <div className="status-card">
          <div className="status-label">
            <Clock size={20} />
            Current Queue Status
            <br />
            தற்போதைய வரிசை நிலை
          </div>
          <div className="status-badge low">
            Low Wait
            <br />
            குறைந்த காத்திருப்பு
          </div>
        </div>

        <div className="section">
          <div className="section-title">
            Inventory Status
            <br />
            சரக்கு நிலை
          </div>
          <div className="inventory-grid">
            <div className="inventory-item">
              <div className="inventory-icon">🌾</div>
              <div className="inventory-name">
                Rice
                <br />
                அரிசி
              </div>
              <div className="inventory-qty">45 kg</div>
              <div className="stock-badge in-stock">
                In Stock
                <br />
                கையிருப்பில்
              </div>
            </div>
            <div className="inventory-item">
              <div className="inventory-icon">🍬</div>
              <div className="inventory-name">
                Sugar
                <br />
                சர்க்கரை
              </div>
              <div className="inventory-qty">45 kg</div>
              <div className="stock-badge limited">
                Limited
                <br />
                குறைந்த அளவு
              </div>
            </div>
            <div className="inventory-item">
              <div className="inventory-icon">🛢️</div>
              <div className="inventory-name">
                Cooking Oil
                <br />
                சமையல் எண்ணெய்
              </div>
              <div className="inventory-qty">80 L</div>
              <div className="stock-badge in-stock">
                In Stock
                <br />
                கையிருப்பில்
              </div>
            </div>
            <div className="inventory-item">
              <div className="inventory-icon">🌾</div>
              <div className="inventory-name">
                Wheat
                <br />
                கோதுமை
              </div>
              <div className="inventory-qty">0 kg</div>
              <div className="stock-badge out-of-stock">
                Out of Stock
                <br />
                இருப்பில் இல்லை
              </div>
            </div>
          </div>
        </div>

        <div className="section">
          <div className="section-title">
            Quick Actions
            <br />
            விரைவு செயல்கள்
          </div>
          <button className="action-button primary" onClick={() => setCurrentScreen('pre-order')}>
            <Package size={20} />
            Pre-Order Items
            <br />
            பொருட்களை முன்பதிவு செய்க
          </button>
          <button className="action-button secondary" onClick={() => setCurrentScreen('book-slot')}>
            <Clock size={20} />
            Book Time Slot
            <br />
            நேர இடைவெளியை முன்பதிவு செய்யவும்
          </button>
          <button className="action-button delivery" onClick={() => setCurrentScreen('delivery-eligibility')}>
            <Truck size={20} />
            Request Doorstep Delivery
            <br />
            வீட்டு வாசல் டெலிவரி கோரவும்
          </button>
        </div>
      </div>

      <BottomNav active="home" setScreen={setCurrentScreen} />
    </div>
  );

  const DeliveryEligibilityScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Delivery Eligibility Check
          <br />
          டெலிவரி தகுதி சரிபார்ப்பு
        </div>
      </div>

      <div className="content">
        <div className="eligibility-card">
          <div className="eligibility-icon">
            <Truck size={48} />
          </div>
          <h3>Doorstep Delivery Service</h3>
          <p className="tamil-subtitle">வீட்டு வாசல் டெலிவரி சேவை</p>
        </div>

        <div className="info-card">
          <AlertCircle size={20} />
          <div className="info-content">
            <strong>Free Delivery Available For:</strong>
            <br />
            இலவச டெலிவரி கிடைக்கும்:
            <ul>
              <li>Senior Citizens (70+ years) / மூத்த குடிமக்கள்</li>
              <li>Differently-abled / மாற்றுத்திறனாளிகள்</li>
              <li>Pregnant Women / கர்ப்பிணி பெண்கள்</li>
              <li>Chronically Ill / நாள்பட்ட நோயாளிகள்</li>
            </ul>
          </div>
        </div>

        <div className="eligibility-status">
          <User size={24} />
          <div>
            <strong>Your Status / உங்கள் நிலை</strong>
            <p>{userCard.headOfFamily} - Age: {userCard.age} years</p>
          </div>
        </div>

        {userCard.age >= 70 ? (
          <div className="success-card">
            <CheckCircle size={24} />
            <div>
              <strong>Eligible for Free Delivery</strong>
              <br />
              இலவச டெலிவரிக்கு தகுதியானவர்
              <p>As a senior citizen, you qualify for free doorstep delivery</p>
            </div>
          </div>
        ) : (
          <div className="fee-card">
            <IndianRupee size={24} />
            <div>
              <strong>Nominal Delivery Fee: ₹25</strong>
              <br />
              சின்னஞ்சிறு டெலிவரி கட்டணம்
              <p>Covers fuel and delivery personnel costs</p>
            </div>
          </div>
        )}

        <div className="delivery-benefits">
          <div className="section-title">Service Benefits / சேவை நன்மைகள்</div>
          <div className="benefit-item">
            <CheckCircle size={16} />
            <span>No queue waiting / வரிசை காத்திருப்பு இல்லை</span>
          </div>
          <div className="benefit-item">
            <CheckCircle size={16} />
            <span>Scheduled delivery to doorstep / திட்டமிட்ட டெலிவரி</span>
          </div>
          <div className="benefit-item">
            <CheckCircle size={16} />
            <span>Electronic weighing at home / வீட்டில் எலக்ட்ரானிக் எடை</span>
          </div>
          <div className="benefit-item">
            <CheckCircle size={16} />
            <span>Digital receipt via SMS / SMS மூலம் டிஜிட்டல் ரசீது</span>
          </div>
          <div className="benefit-item">
            <CheckCircle size={16} />
            <span>Live tracking on delivery day / டெலிவரி நாளில் நேரலை கண்காணிப்பு</span>
          </div>
        </div>

        <button 
          className="confirm-button"
          onClick={() => {
            setDeliveryEligibility(userCard.age >= 70 ? 'eligible' : 'fee-based');
            setCurrentScreen('delivery-address');
          }}
        >
          Continue to Address Verification
          <br />
          முகவரி சரிபார்ப்புக்கு தொடரவும்
        </button>
      </div>
    </div>
  );

  const DeliveryAddressScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('delivery-eligibility')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Delivery Address
          <br />
          டெலிவரி முகவரி
        </div>
      </div>

      <div className="content">
        <div className="info-box">
          <MapPin size={20} />
          Verify your delivery address. Must be within 5km of registered shop.
          <br />
          உங்கள் டெலிவரி முகவரியை சரிபார்க்கவும்.
        </div>

        <div className="address-card">
          <div className="address-header">
            <MapPin size={20} />
            <span>Registered Address / பதிவு செய்யப்பட்ட முகவரி</span>
          </div>
          <div className="address-content">
            <p><strong>{deliveryAddress.line1}</strong></p>
            <p>{deliveryAddress.line2}</p>
            <p>{deliveryAddress.city} - {deliveryAddress.pincode}</p>
            <p className="landmark">
              <Navigation size={14} />
              Landmark: {deliveryAddress.landmark}
            </p>
            <p className="contact">
              <Phone size={14} />
              Contact: {deliveryAddress.phone}
            </p>
          </div>
          <button className="edit-address-btn">
            Edit Address / முகவரியைத் திருத்தவும்
          </button>
        </div>

        <div className="map-preview">
          <div className="map-placeholder-small">
            <MapPin size={32} />
            <span>Anna Nagar West Extension</span>
            <div className="distance-info">0.8 km from Shop #402</div>
          </div>
        </div>

        <div className="delivery-instructions">
          <div className="section-title">Delivery Instructions (Optional)</div>
          <textarea 
            className="instructions-input"
            placeholder="Add any special instructions for delivery personnel...&#10;டெலிவரி பணியாளருக்கான சிறப்பு வழிமுறைகளைச் சேர்க்கவும்..."
            rows="3"
          />
        </div>

        <button 
          className="confirm-button"
          onClick={() => setCurrentScreen('delivery-pre-order')}
        >
          Confirm Address & Continue
          <br />
          முகவரியை உறுதிப்படுத்தி தொடரவும்
        </button>
      </div>
    </div>
  );

  const DeliveryPreOrderScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('delivery-address')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Select Items for Delivery
          <br />
          டெலிவரிக்கான பொருட்களைத் தேர்ந்தெடுக்கவும்
        </div>
      </div>

      <div className="content">
        <div className="info-box delivery">
          <Package size={20} />
          Items will be delivered to your doorstep. Select quantities within your quota.
          <br />
          பொருட்கள் உங்கள் வீட்டு வாசலுக்கு டெலிவரி செய்யப்படும்.
        </div>

        <div className="section">
          <div className="section-title">
            Available Commodities
            <br />
            கிடைக்கக்கூடிய பொருட்கள்
          </div>

          <div className="commodity-list">
            <div className="commodity-item">
              <div className="commodity-header">
                <span>Rice / அரிசி</span>
                <span className="commodity-tag">Free</span>
              </div>
              <div className="commodity-info">Max: 20 kg • Free under NFSA</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, rice: Math.max(0, selectedItems.rice - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.rice} kg</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, rice: Math.min(20, selectedItems.rice + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>

            <div className="commodity-item">
              <div className="commodity-header">
                <span>Sugar / சர்க்கரை</span>
                <span className="commodity-tag">₹25/kg</span>
              </div>
              <div className="commodity-info">Max: 2 kg • ₹25/kg</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, sugar: Math.max(0, selectedItems.sugar - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.sugar} kg</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, sugar: Math.min(2, selectedItems.sugar + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>

            <div className="commodity-item">
              <div className="commodity-header">
                <span>Cooking Oil / சமையல் எண்ணெய்</span>
                <span className="commodity-tag">₹100/L</span>
              </div>
              <div className="commodity-info">Max: 2 L • ₹100/L</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, cookingOil: Math.max(0, selectedItems.cookingOil - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.cookingOil} L</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, cookingOil: Math.min(2, selectedItems.cookingOil + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="total-section delivery-total">
          <div className="total-breakdown">
            <div className="breakdown-row">
              <span>Items Total / பொருட்கள் மொத்தம்</span>
              <span>₹{calculateTotal()}</span>
            </div>
            <div className="breakdown-row delivery-fee-row">
              <span>Delivery Fee / டெலிவரி கட்டணம்</span>
              <span className={calculateDeliveryFee() === 0 ? 'free-tag' : ''}>
                {calculateDeliveryFee() === 0 ? 'FREE' : `₹${calculateDeliveryFee()}`}
              </span>
            </div>
            <div className="breakdown-row total-row">
              <span><strong>Total Amount / மொத்த தொகை</strong></span>
              <span><strong>₹{calculateTotal() + calculateDeliveryFee()}</strong></span>
            </div>
          </div>
        </div>

        <button 
          className="confirm-button"
          onClick={() => setCurrentScreen('delivery-schedule')}
        >
          Continue to Schedule Delivery
          <br />
          டெலிவரி திட்டமிட தொடரவும்
        </button>
      </div>
    </div>
  );

  const DeliveryScheduleScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('delivery-pre-order')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Schedule Delivery
          <br />
          டெலிவரி திட்டமிடவும்
        </div>
      </div>

      <div className="content">
        <div className="info-box">
          <Calendar size={20} />
          Deliveries operate on fixed routes. Select available date and time window.
          <br />
          டெலிவரிகள் நிலையான வழித்தடங்களில் செயல்படுகின்றன.
        </div>

        <div className="section">
          <div className="section-title">
            Available Delivery Dates
            <br />
            கிடைக்கக்கூடிய டெலிவரி தேதிகள்
          </div>
          <div className="delivery-dates-list">
            {deliveryDates.map((dateObj, idx) => (
              <button
                key={idx}
                className={`delivery-date-card ${selectedDeliveryDate === idx ? 'selected' : ''} ${!dateObj.available ? 'disabled' : ''}`}
                onClick={() => dateObj.available && setSelectedDeliveryDate(idx)}
                disabled={!dateObj.available}
              >
                <div className="date-card-header">
                  <Calendar size={20} />
                  <span className="date-text">{dateObj.date}</span>
                  {selectedDeliveryDate === idx && <Check className="check-icon-small" />}
                </div>
                <div className="date-card-info">
                  <div className="route-info">
                    <Truck size={14} />
                    Route: {dateObj.routeId}
                  </div>
                  <div className="capacity-info">
                    {dateObj.available ? (
                      <span className="available-tag">{30 - dateObj.deliveries} slots available</span>
                    ) : (
                      <span className="full-tag">Fully Booked</span>
                    )}
                  </div>
                </div>
              </button>
            ))}
          </div>
        </div>

        {selectedDeliveryDate !== null && (
          <div className="section">
            <div className="section-title">
              Select Time Window
              <br />
              நேர இடைவெளியைத் தேர்ந்தெடுக்கவும்
            </div>
            <div className="delivery-time-slots">
              {deliveryTimeSlots.map((slot, idx) => (
                <button
                  key={idx}
                  className={`delivery-slot-card ${selectedDeliverySlot === idx ? 'selected' : ''}`}
                  onClick={() => setSelectedDeliverySlot(idx)}
                >
                  <Clock size={20} />
                  <div className="slot-details">
                    <strong>{slot.label}</strong>
                    <span>{slot.time}</span>
                  </div>
                  {selectedDeliverySlot === idx && <Check className="check-icon-small" />}
                </button>
              ))}
            </div>
          </div>
        )}

        {selectedDeliveryDate !== null && selectedDeliverySlot !== null && (
          <div className="delivery-note">
            <AlertCircle size={16} />
            <span>
              You will receive SMS updates on delivery day with live tracking link and agent contact.
              <br />
              டெலிவரி நாளில் நேரலை கண்காணிப்பு இணைப்புடன் SMS புதுப்பிப்புகளைப் பெறுவீர்கள்.
            </span>
          </div>
        )}

        <button 
          className="confirm-button"
          disabled={selectedDeliveryDate === null || selectedDeliverySlot === null}
          onClick={() => setCurrentScreen('delivery-review')}
        >
          Review Order
          <br />
          ஆர்டரை மதிப்பாய்வு செய்யவும்
        </button>
      </div>
    </div>
  );

  const DeliveryReviewScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('delivery-schedule')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Review & Confirm Delivery
          <br />
          மதிப்பாய்வு மற்றும் உறுதிப்படுத்தவும்
        </div>
      </div>

      <div className="content">
        <div className="review-section">
          <div className="review-header">
            <Package size={20} />
            <span>Order Summary / ஆர்டர் சுருக்கம்</span>
          </div>
          <div className="review-items">
            {selectedItems.rice > 0 && (
              <div className="review-item">
                <span>Rice / அரிசி</span>
                <span>{selectedItems.rice} kg</span>
              </div>
            )}
            {selectedItems.sugar > 0 && (
              <div className="review-item">
                <span>Sugar / சர்க்கரை</span>
                <span>{selectedItems.sugar} kg</span>
              </div>
            )}
            {selectedItems.cookingOil > 0 && (
              <div className="review-item">
                <span>Cooking Oil / சமையல் எண்ணெய்</span>
                <span>{selectedItems.cookingOil} L</span>
              </div>
            )}
          </div>
        </div>

        <div className="review-section">
          <div className="review-header">
            <MapPin size={20} />
            <span>Delivery Address / டெலிவரி முகவரி</span>
          </div>
          <div className="review-content">
            <p>{deliveryAddress.line1}, {deliveryAddress.line2}</p>
            <p>{deliveryAddress.city} - {deliveryAddress.pincode}</p>
            <p className="landmark-review">Landmark: {deliveryAddress.landmark}</p>
          </div>
        </div>

        <div className="review-section">
          <div className="review-header">
            <Calendar size={20} />
            <span>Delivery Schedule / டெலிவரி அட்டவணை</span>
          </div>
          <div className="review-content">
            <p><strong>{deliveryDates[selectedDeliveryDate]?.date}</strong></p>
            <p>{deliveryTimeSlots[selectedDeliverySlot]?.time}</p>
            <p className="route-review">Route: {deliveryDates[selectedDeliveryDate]?.routeId}</p>
          </div>
        </div>

        <div className="review-section payment">
          <div className="review-header">
            <IndianRupee size={20} />
            <span>Payment Summary / கட்டண சுருக்கம்</span>
          </div>
          <div className="payment-breakdown">
            <div className="payment-row">
              <span>Items Total</span>
              <span>₹{calculateTotal()}</span>
            </div>
            <div className="payment-row">
              <span>Delivery Fee</span>
              <span className={calculateDeliveryFee() === 0 ? 'free-tag' : ''}>
                {calculateDeliveryFee() === 0 ? 'FREE' : `₹${calculateDeliveryFee()}`}
              </span>
            </div>
            <div className="payment-row total">
              <span><strong>Total Payable</strong></span>
              <span><strong>₹{calculateTotal() + calculateDeliveryFee()}</strong></span>
            </div>
          </div>
        </div>

        <div className="terms-section">
          <AlertCircle size={16} />
          <div className="terms-content">
            <strong>Cancellation Policy / ரத்து கொள்கை</strong>
            <ul>
              <li>Free cancellation up to 48 hours before delivery</li>
              <li>50% refund for 24-48 hours before</li>
              <li>No refund within 24 hours</li>
            </ul>
          </div>
        </div>

        <button 
          className="confirm-button"
          onClick={() => {
            setDeliveryConfirmed(true);
            setCurrentScreen('delivery-confirmation');
          }}
        >
          Confirm & Place Order
          <br />
          உறுதிப்படுத்தி ஆர்டர் செய்யவும்
        </button>
      </div>
    </div>
  );

  const DeliveryConfirmationScreen = () => (
    <div className="screen confirmation">
      <div className="header success">
        <div className="header-title">
          <CheckCircle size={24} />
          Delivery Confirmed!
          <br />
          டெலிவரி உறுதிப்படுத்தப்பட்டது!
        </div>
      </div>

      <div className="content">
        <div className="confirmation-icon">
          <Truck size={64} />
        </div>

        <div className="order-id-card">
          <div className="order-label">Delivery Order ID / டெலிவரி ஆர்டர் எண்</div>
          <div className="order-number">{deliveryOrderId}</div>
        </div>

        <div className="delivery-details-card">
          <div className="detail-section">
            <Calendar size={20} />
            <div>
              <strong>Scheduled Delivery / திட்டமிட்ட டெலிவரி</strong>
              <p>{deliveryDates[selectedDeliveryDate]?.date}</p>
              <p>{deliveryTimeSlots[selectedDeliverySlot]?.time}</p>
            </div>
          </div>

          <div className="detail-section">
            <MapPin size={20} />
            <div>
              <strong>Delivery Address / டெலிவரி முகவரி</strong>
              <p>{deliveryAddress.line1}</p>
              <p>{deliveryAddress.line2}</p>
            </div>
          </div>

          <div className="detail-section">
            <Phone size={20} />
            <div>
              <strong>Contact Number / தொடர்பு எண்</strong>
              <p>{deliveryAddress.phone}</p>
            </div>
          </div>
        </div>

        <div className="next-steps-card">
          <div className="steps-header">Next Steps / அடுத்த படிகள்</div>
          <div className="step-item">
            <CheckCircle size={16} />
            <span>You will receive SMS confirmation shortly</span>
          </div>
          <div className="step-item">
            <CheckCircle size={16} />
            <span>24 hours before: Delivery reminder SMS</span>
          </div>
          <div className="step-item">
            <CheckCircle size={16} />
            <span>On delivery day: Live tracking link & agent contact</span>
          </div>
          <div className="step-item">
            <CheckCircle size={16} />
            <span>After delivery: Digital receipt via SMS</span>
          </div>
        </div>

        <div className="action-buttons">
          <button className="secondary-btn" onClick={() => setCurrentScreen('shop-details')}>
            Back to Home
            <br />
            முகப்புக்குத் திரும்பு
          </button>
          <button className="primary-btn" onClick={() => setCurrentScreen('track-delivery')}>
            <Navigation size={20} />
            Track Delivery
            <br />
            டெலிவரியைக் கண்காணிக்கவும்
          </button>
        </div>
      </div>
    </div>
  );

  const TrackDeliveryScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Track Delivery
          <br />
          டெலிவரியைக் கண்காணிக்கவும்
        </div>
      </div>

      <div className="content">
        <div className="tracking-header">
          <Package size={32} />
          <div>
            <h3>Order #{deliveryOrderId}</h3>
            <p className="tracking-status">Out for Delivery</p>
          </div>
        </div>

        <div className="tracking-map">
          <div className="map-tracking-view">
            <Truck size={48} />
            <div className="tracking-pulse"></div>
            <div className="tracking-info">Delivery vehicle is 2.5 km away</div>
          </div>
        </div>

        <div className="timeline">
          <div className="timeline-item completed">
            <div className="timeline-dot"></div>
            <div className="timeline-content">
              <strong>Order Confirmed</strong>
              <span>Sat, Jan 4 - 08:00 AM</span>
            </div>
          </div>
          <div className="timeline-item completed">
            <div className="timeline-dot"></div>
            <div className="timeline-content">
              <strong>Items Packed at Shop</strong>
              <span>Sat, Jan 4 - 08:45 AM</span>
            </div>
          </div>
          <div className="timeline-item active">
            <div className="timeline-dot"></div>
            <div className="timeline-content">
              <strong>Out for Delivery</strong>
              <span>Sat, Jan 4 - 09:30 AM</span>
              <div className="delivery-agent">
                <User size={16} />
                <span>Agent: Rajesh Kumar</span>
                <Phone size={16} style={{ marginLeft: 'auto', cursor: 'pointer' }} />
              </div>
            </div>
          </div>
          <div className="timeline-item pending">
            <div className="timeline-dot"></div>
            <div className="timeline-content">
              <strong>Delivered</strong>
              <span>ETA: 10:15 AM</span>
            </div>
          </div>
        </div>

        <div className="delivery-route-info">
          <div className="route-header">
            <Navigation size={20} />
            <span>Route Progress / வழித்தட முன்னேற்றம்</span>
          </div>
          <div className="route-stats">
            <div className="stat">
              <strong>8/30</strong>
              <span>Deliveries Completed</span>
            </div>
            <div className="stat">
              <strong>22</strong>
              <span>Remaining</span>
            </div>
            <div className="stat">
              <strong>~45 min</strong>
              <span>ETA to Your Location</span>
            </div>
          </div>
        </div>

        <button className="refresh-btn">
          <Navigation size={20} />
          Refresh Location / இடத்தைப் புதுப்பிக்கவும்
        </button>
      </div>
    </div>
  );

  const PreOrderScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Pre-Order Items
          <br />
          பொருட்களை முன்பதிவு செய்க
        </div>
      </div>

      <div className="content">
        <div className="info-box">
          Select items within your monthly quota
          <br />
          உங்கள் மாதாந்திர ஒதுக்கீட்டுக்குள் பொருட்களைத் தேர்ந்தெடுக்கவும்
        </div>

        <div className="section">
          <div className="section-title">
            Available Commodities
            <br />
            கிடைக்கக்கூடிய பொருட்கள்
          </div>

          <div className="commodity-list">
            <div className="commodity-item">
              <div className="commodity-header">
                <span>Rice / அரிசி</span>
                <span className="commodity-tag">₹3</span>
              </div>
              <div className="commodity-info">Max: 20 kg • ₹3/kg</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, rice: Math.max(0, selectedItems.rice - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.rice} kg</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, rice: Math.min(20, selectedItems.rice + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>

            <div className="commodity-item">
              <div className="commodity-header">
                <span>Sugar / சர்க்கரை</span>
              </div>
              <div className="commodity-info">Max: 2 kg • ₹45/kg</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, sugar: Math.max(0, selectedItems.sugar - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.sugar} kg</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, sugar: Math.min(2, selectedItems.sugar + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>

            <div className="commodity-item">
              <div className="commodity-header">
                <span>Cooking Oil / சமையல் எண்ணெய்</span>
                <span className="commodity-tag">₹100</span>
              </div>
              <div className="commodity-info">Max: 2 L • ₹100/L</div>
              <div className="quantity-control">
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, cookingOil: Math.max(0, selectedItems.cookingOil - 1)})}
                >
                  <Minus size={16} />
                </button>
                <div className="qty-display">{selectedItems.cookingOil} L</div>
                <button 
                  className="qty-btn"
                  onClick={() => setSelectedItems({...selectedItems, cookingOil: Math.min(2, selectedItems.cookingOil + 1)})}
                >
                  <Plus size={16} />
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="total-section">
          <div className="total-label">
            Estimated Total
            <br />
            மதிப்பிடப்பட்ட மொத்தம்
          </div>
          <div className="total-amount">₹{calculateTotal()}</div>
          <div className="total-items">3 items</div>
        </div>

        <button className="confirm-button" onClick={() => setCurrentScreen('book-slot')}>
          Confirm Items
          <br />
          பொருட்களை உறுதிப்படுத்தவும்
        </button>
      </div>
    </div>
  );

  const BookSlotScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('pre-order')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Book Time Slot
          <br />
          நேர இடைவெளியை முன்பதிவு செய்யவும்
        </div>
      </div>

      <div className="content">
        <div className="section">
          <div className="section-title">
            Select Date
            <br />
            தேதியைத் தேர்ந்தெடுக்கவும்
          </div>
          <div className="date-selector">
            {['today', 'tomorrow', 'wed', 'thu'].map((day, idx) => (
              <button
                key={day}
                className={`date-btn ${selectedDate === day ? 'active' : ''}`}
                onClick={() => setSelectedDate(day)}
              >
                <div className="date-day">
                  {day === 'today' ? 'Today' : day === 'tomorrow' ? 'Tomorrow' : day === 'wed' ? 'Wed' : 'Thu'}
                </div>
                <div className="date-label">
                  {day === 'today' ? 'இன்று' : day === 'tomorrow' ? 'நாளை' : day === 'wed' ? 'புதன்' : 'வியாழன்'}
                </div>
                <div className="date-number">Dec {23 + idx}</div>
              </button>
            ))}
          </div>
        </div>

        <div className="section">
          <div className="section-title">
            Available Time Slots
            <br />
            கிடைக்கக்கூடிய நேர இடைவெளிகள்
          </div>
          <div className="slot-list">
            {timeSlots.map((slot, idx) => (
              <button
                key={idx}
                className={`slot-item ${selectedSlot === idx ? 'selected' : ''} ${slot.status === 'full' ? 'disabled' : ''}`}
                onClick={() => slot.status !== 'full' && setSelectedSlot(idx)}
                disabled={slot.status === 'full'}
              >
                <Clock size={20} />
                <div className="slot-time">{slot.time}</div>
                <div className="slot-status">
                  {slot.status === 'vacant' && (
                    <>
                      <span className="status-dot vacant"></span>
                      Vacant ({slot.count} slots left)
                      <br />
                      காலியிடம் உள்ளது ({slot.count} இடங்கள்)
                    </>
                  )}
                  {slot.status === 'filling' && (
                    <>
                      <span className="status-dot filling"></span>
                      Filling Fast ({slot.count} left)
                      <br />
                      விரைவாக நிரம்புகிறது ({slot.count})
                    </>
                  )}
                  {slot.status === 'full' && (
                    <>
                      <span className="status-dot full"></span>
                      Full
                      <br />
                      நிரம்பியது
                    </>
                  )}
                </div>
                {selectedSlot === idx && <Check className="check-icon" />}
              </button>
            ))}
          </div>
        </div>

        <button 
          className="confirm-button"
          disabled={selectedSlot === null}
          onClick={() => {
            setBookingConfirmed(true);
            setCurrentScreen('confirmation');
          }}
        >
          Confirm Slot & Get Token
          <br />
          இடைவெளியை உறுதிப்படுத்தி டோக்கன் பெறவும்
        </button>
      </div>
    </div>
  );

  const ConfirmationScreen = () => (
    <div className="screen confirmation">
      <div className="header success">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Booking Confirmed!
          <br />
          முன்பதிவு உறுதிப்படுத்தப்பட்டது!
        </div>
      </div>

      <div className="content">
        <div className="token-card">
          <div className="token-label">
            Your Token Number
            <br />
            உங்கள் டோக்கன் எண்
          </div>
          <div className="token-number">{tokenNumber}</div>
          <div className="token-time">
            Time Slot / நேர இடைவெளி
            <br />
            10:00 AM - 11:00 AM
            <br />
            Today, Dec 23, 2025
          </div>
        </div>

        <div className="qr-section">
          <div className="qr-label">
            Digital Token
            <br />
            டிஜிட்டல் டோக்கன்
          </div>
          <div className="qr-code">
            <svg viewBox="0 0 100 100" className="qr-svg">
              {Array.from({length: 10}, (_, i) => 
                Array.from({length: 10}, (_, j) => (
                  Math.random() > 0.5 && 
                  <rect key={`${i}-${j}`} x={i*10} y={j*10} width="10" height="10" fill="#000" />
                ))
              )}
              <circle cx="50" cy="50" r="15" fill="#2D5F4F" />
              <text x="50" y="55" textAnchor="middle" fill="white" fontSize="12" fontWeight="bold">A-142</text>
            </svg>
          </div>
          <div className="qr-instruction">
            Show this at the counter
            <br />
            இதை கவுண்டரில் காட்டவும்
          </div>
        </div>

        <div className="booking-details">
          <div className="detail-row">
            <MapPin size={16} />
            <div>
              <div className="detail-label">Shop Location / கடை இடம்</div>
              <div className="detail-value">
                {shopDetails.name}
                <br />
                {shopDetails.location}
              </div>
            </div>
          </div>
        </div>

        <button className="save-button">
          Save to Gallery
          <br />
          கேலரியில் சேமிக்கவும்
        </button>
      </div>
    </div>
  );

  const RationCardScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          My Ration Card
          <br />
          எனது ரேஷன் அட்டை
        </div>
      </div>

      <div className="content">
        <div className="card-view">
          <div className="card-header">
            <div className="card-label">Card Number / அட்டை எண்</div>
            <CreditCard size={24} />
          </div>
          <div className="card-number">{userCard.cardNumber}</div>
          <div className="card-type">
            Card Type / அட்டை வகை
            <br />
            <strong>{userCard.cardType}</strong>
            <br />
            முன்னுரிமை குடும்பம் (குடும்ப அட்டை)
          </div>
        </div>

        <div className="family-info">
          <div className="info-label">
            Head of Family
            <br />
            குடும்பத் தலைவர்
          </div>
          <div className="info-value">{userCard.headOfFamily}</div>
          <div className="info-tamil">திருமதி. லட்சுமி சுந்தரம்</div>
        </div>

        <div className="shop-info">
          <div className="info-label">
            Registered Shop
            <br />
            பதிவு செய்யப்பட்ட கடை
          </div>
          <div className="info-value">
            {userCard.shop}
            <br />
            {shopDetails.location}
          </div>
        </div>

        <div className="entitlements">
          <div className="section-title">
            Monthly Quota Entitlement
            <br />
            மாதாந்திர ஒதுக்கீடு உரிமை
          </div>
          <div className="entitlement-list">
            <div className="entitlement-row">
              <span>Rice / அரிசி</span>
              <span className="entitlement-qty">{userCard.entitlements.rice} kg</span>
            </div>
            <div className="entitlement-row">
              <span>Sugar / சர்க்கரை</span>
              <span className="entitlement-qty">{userCard.entitlements.sugar} kg</span>
            </div>
            <div className="entitlement-row">
              <span>Cooking Oil / சமையல் எண்ணெய்</span>
              <span className="entitlement-qty">{userCard.entitlements.cookingOil} L</span>
            </div>
            <div className="entitlement-row">
              <span>Wheat / கோதுமை</span>
              <span className="entitlement-qty">{userCard.entitlements.wheat} kg</span>
            </div>
          </div>
        </div>

        <button className="view-family-button">
          View Family Members
          <br />
          குடும்ப உறுப்பினர்களைப் பார்க்கவும்
        </button>
      </div>

      <BottomNav active="card" setScreen={setCurrentScreen} />
    </div>
  );

  const FindShopsScreen = () => (
    <div className="screen">
      <div className="header">
        <ChevronLeft onClick={() => setCurrentScreen('shop-details')} style={{ cursor: 'pointer' }} />
        <div className="header-title">
          Find Nearby Shops
          <br />
          அருகிலுள்ள கடைகளைக் கண்டறியவும்
        </div>
      </div>

      <div className="content no-padding">
        <div className="map-view">
          <div className="map-placeholder">
            <div className="you-marker">You are here</div>
            <div className="shop-marker shop-1">Shop</div>
            <div className="shop-marker shop-2">Shop</div>
            <div className="shop-marker shop-3">Shop</div>
          </div>
        </div>

        <div className="shops-list">
          <div className="list-title">
            Nearby Fair Price Shops
            <br />
            அருகிலுள்ள நியாய விலைக் கடைகள்
          </div>
          
          {nearbyShops.map(shop => (
            <div key={shop.id} className="shop-card">
              <div className="shop-header">
                <div>
                  <div className="shop-name-small">{shop.name}</div>
                  {shop.registered && <span className="registered-badge">Registered</span>}
                </div>
              </div>
              <div className="shop-address">{shop.address}</div>
              <div className="shop-distance">{shop.distance} away</div>
              <div className="shop-actions">
                <button className="check-stock-btn">
                  Check Stock
                  <br />
                  இருப்பைச் சரிபார்க்கவும்
                </button>
                <button className="call-btn">
                  <Phone size={20} />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      <BottomNav active="map" setScreen={setCurrentScreen} />
    </div>
  );

  const BottomNav = ({ active, setScreen }) => (
    <div className="bottom-nav">
      <button 
        className={`nav-item ${active === 'home' ? 'active' : ''}`}
        onClick={() => setScreen('shop-details')}
      >
        <Home size={24} />
        <span>Home</span>
      </button>
      <button 
        className={`nav-item ${active === 'card' ? 'active' : ''}`}
        onClick={() => setScreen('ration-card')}
      >
        <CreditCard size={24} />
        <span>Card</span>
      </button>
      <button 
        className={`nav-item ${active === 'map' ? 'active' : ''}`}
        onClick={() => setScreen('find-shops')}
      >
        <Map size={24} />
        <span>Map</span>
      </button>
      <button className="nav-item">
        <Clock size={24} />
        <span>History</span>
      </button>
    </div>
  );

  // Render current screen
  return (
    <div className="app-container">
      {currentScreen === 'shop-details' && <ShopDetailsScreen />}
      {currentScreen === 'pre-order' && <PreOrderScreen />}
      {currentScreen === 'book-slot' && <BookSlotScreen />}
      {currentScreen === 'confirmation' && <ConfirmationScreen />}
      {currentScreen === 'ration-card' && <RationCardScreen />}
      {currentScreen === 'find-shops' && <FindShopsScreen />}
      {currentScreen === 'delivery-eligibility' && <DeliveryEligibilityScreen />}
      {currentScreen === 'delivery-address' && <DeliveryAddressScreen />}
      {currentScreen === 'delivery-pre-order' && <DeliveryPreOrderScreen />}
      {currentScreen === 'delivery-schedule' && <DeliveryScheduleScreen />}
      {currentScreen === 'delivery-review' && <DeliveryReviewScreen />}
      {currentScreen === 'delivery-confirmation' && <DeliveryConfirmationScreen />}
      {currentScreen === 'track-delivery' && <TrackDeliveryScreen />}

      <style jsx>{`
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        .app-container {
          font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
          background: #f5f5f5;
          min-height: 100vh;
          display: flex;
          justify-content: center;
          align-items: center;
          padding: 20px;
        }

        .screen {
          width: 100%;
          max-width: 420px;
          height: 90vh;
          max-height: 900px;
          background: white;
          border-radius: 24px;
          box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
          display: flex;
          flex-direction: column;
          overflow: hidden;
          position: relative;
        }

        .header {
          background: linear-gradient(135deg, #2D5F4F 0%, #3A7563 100%);
          color: white;
          padding: 20px;
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .header.success {
          background: linear-gradient(135deg, #2D5F4F 0%, #4A8B76 100%);
        }

        .header-title {
          flex: 1;
          font-size: 14px;
          line-height: 1.4;
        }

        .header-icon {
          opacity: 0.9;
        }

        .shop-name {
          font-size: 18px;
          font-weight: 600;
          margin-top: 5px;
        }

        .content {
          flex: 1;
          overflow-y: auto;
          padding: 20px;
          padding-bottom: 80px;
        }

        .content.no-padding {
          padding: 0;
        }

        .status-card {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 16px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;
        }

        .status-label {
          display: flex;
          align-items: center;
          gap: 8px;
          font-size: 13px;
          line-height: 1.5;
          color: #666;
        }

        .status-badge {
          padding: 8px 16px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: 600;
          text-align: center;
          line-height: 1.4;
        }

        .status-badge.low {
          background: #d4edda;
          color: #155724;
        }

        .section {
          margin-bottom: 24px;
        }

        .section-title {
          font-size: 16px;
          font-weight: 600;
          margin-bottom: 12px;
          color: #2D5F4F;
          line-height: 1.5;
        }

        .inventory-grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 12px;
        }

        .inventory-item {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          text-align: center;
        }

        .inventory-icon {
          font-size: 32px;
          margin-bottom: 8px;
        }

        .inventory-name {
          font-size: 12px;
          font-weight: 600;
          margin-bottom: 4px;
          line-height: 1.4;
        }

        .inventory-qty {
          font-size: 14px;
          color: #666;
          margin-bottom: 8px;
        }

        .stock-badge {
          padding: 4px 12px;
          border-radius: 12px;
          font-size: 10px;
          font-weight: 600;
          line-height: 1.4;
        }

        .stock-badge.in-stock {
          background: #d4edda;
          color: #155724;
        }

        .stock-badge.limited {
          background: #fff3cd;
          color: #856404;
        }

        .stock-badge.out-of-stock {
          background: #f8d7da;
          color: #721c24;
        }

        .action-button {
          width: 100%;
          padding: 16px;
          border: none;
          border-radius: 12px;
          font-size: 14px;
          font-weight: 600;
          cursor: pointer;
          margin-bottom: 12px;
          display: flex;
          align-items: center;
          gap: 12px;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .action-button:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .action-button.primary {
          background: #2D5F4F;
          color: white;
        }

        .action-button.secondary {
          background: #FF8C42;
          color: white;
        }

        .action-button.delivery {
          background: #6366F1;
          color: white;
        }

        .bottom-nav {
          position: absolute;
          bottom: 0;
          left: 0;
          right: 0;
          background: white;
          border-top: 1px solid #e0e0e0;
          display: flex;
          justify-content: space-around;
          padding: 12px 0;
        }

        .nav-item {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 4px;
          border: none;
          background: none;
          color: #999;
          cursor: pointer;
          font-size: 12px;
          transition: color 0.3s ease;
        }

        .nav-item:hover,
        .nav-item.active {
          color: #2D5F4F;
        }

        .info-box {
          background: #fff3cd;
          border-left: 4px solid #ffc107;
          padding: 12px;
          border-radius: 8px;
          font-size: 13px;
          line-height: 1.5;
          margin-bottom: 20px;
          display: flex;
          align-items: start;
          gap: 10px;
        }

        .info-box.delivery {
          background: #e8f4fd;
          border-left-color: #6366F1;
        }

        .commodity-list {
          display: flex;
          flex-direction: column;
          gap: 16px;
        }

        .commodity-item {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
        }

        .commodity-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 8px;
          font-weight: 600;
        }

        .commodity-tag {
          background: #2D5F4F;
          color: white;
          padding: 4px 12px;
          border-radius: 12px;
          font-size: 12px;
        }

        .commodity-info {
          font-size: 12px;
          color: #666;
          margin-bottom: 12px;
        }

        .quantity-control {
          display: flex;
          align-items: center;
          gap: 16px;
        }

        .qty-btn {
          width: 36px;
          height: 36px;
          border-radius: 8px;
          border: none;
          background: #2D5F4F;
          color: white;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          transition: all 0.3s ease;
        }

        .qty-btn:hover {
          background: #3A7563;
          transform: scale(1.1);
        }

        .qty-display {
          flex: 1;
          text-align: center;
          font-size: 16px;
          font-weight: 600;
        }

        .total-section {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 16px;
          margin: 20px 0;
        }

        .total-section.delivery-total .total-breakdown {
          display: flex;
          flex-direction: column;
          gap: 12px;
        }

        .breakdown-row {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 14px;
        }

        .breakdown-row.total-row {
          padding-top: 12px;
          border-top: 2px solid #dee2e6;
          font-size: 16px;
        }

        .free-tag {
          background: #d4edda;
          color: #155724;
          padding: 4px 8px;
          border-radius: 6px;
          font-size: 12px;
          font-weight: 600;
        }

        .total-label {
          font-size: 13px;
          line-height: 1.5;
          color: #666;
        }

        .total-amount {
          font-size: 24px;
          font-weight: 700;
          color: #2D5F4F;
        }

        .total-items {
          font-size: 12px;
          color: #999;
        }

        .confirm-button {
          width: 100%;
          padding: 16px;
          background: #FF8C42;
          color: white;
          border: none;
          border-radius: 12px;
          font-size: 15px;
          font-weight: 600;
          cursor: pointer;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .confirm-button:hover:not(:disabled) {
          background: #FF7829;
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(255, 140, 66, 0.3);
        }

        .confirm-button:disabled {
          background: #ccc;
          cursor: not-allowed;
        }

        .date-selector {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 8px;
          margin-bottom: 20px;
        }

        .date-btn {
          padding: 12px 8px;
          border: 2px solid #e0e0e0;
          background: white;
          border-radius: 12px;
          cursor: pointer;
          text-align: center;
          transition: all 0.3s ease;
        }

        .date-btn:hover {
          border-color: #2D5F4F;
        }

        .date-btn.active {
          background: #2D5F4F;
          color: white;
          border-color: #2D5F4F;
        }

        .date-day {
          font-weight: 600;
          font-size: 13px;
        }

        .date-label {
          font-size: 11px;
          opacity: 0.8;
          margin: 4px 0;
        }

        .date-number {
          font-size: 12px;
          opacity: 0.7;
        }

        .slot-list {
          display: flex;
          flex-direction: column;
          gap: 12px;
        }

        .slot-item {
          position: relative;
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 16px;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          background: white;
          cursor: pointer;
          transition: all 0.3s ease;
          text-align: left;
        }

        .slot-item:hover:not(.disabled) {
          border-color: #2D5F4F;
          transform: translateX(4px);
        }

        .slot-item.selected {
          background: #e8f5f1;
          border-color: #2D5F4F;
        }

        .slot-item.disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .slot-time {
          font-weight: 600;
          font-size: 14px;
          margin-bottom: 4px;
        }

        .slot-status {
          font-size: 12px;
          line-height: 1.5;
          color: #666;
          display: flex;
          align-items: center;
          gap: 6px;
        }

        .status-dot {
          width: 8px;
          height: 8px;
          border-radius: 50%;
        }

        .status-dot.vacant {
          background: #28a745;
        }

        .status-dot.filling {
          background: #ffc107;
        }

        .status-dot.full {
          background: #dc3545;
        }

        .check-icon {
          position: absolute;
          right: 16px;
          color: #2D5F4F;
        }

        .check-icon-small {
          color: #2D5F4F;
          margin-left: auto;
        }

        .token-card {
          background: linear-gradient(135deg, #2D5F4F 0%, #3A7563 100%);
          color: white;
          border-radius: 16px;
          padding: 24px;
          text-align: center;
          margin-bottom: 20px;
        }

        .token-label {
          font-size: 13px;
          opacity: 0.9;
          margin-bottom: 12px;
          line-height: 1.5;
        }

        .token-number {
          font-size: 56px;
          font-weight: 700;
          letter-spacing: 2px;
          margin-bottom: 16px;
        }

        .token-time {
          font-size: 14px;
          line-height: 1.6;
          opacity: 0.95;
        }

        .qr-section {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 16px;
          padding: 20px;
          text-align: center;
          margin-bottom: 20px;
        }

        .qr-label {
          font-size: 13px;
          color: #666;
          margin-bottom: 16px;
          line-height: 1.5;
        }

        .qr-code {
          width: 200px;
          height: 200px;
          margin: 0 auto 16px;
          background: white;
          border: 4px solid #f0f0f0;
          border-radius: 12px;
          padding: 16px;
        }

        .qr-svg {
          width: 100%;
          height: 100%;
        }

        .qr-instruction {
          background: #fff3cd;
          color: #856404;
          padding: 12px;
          border-radius: 8px;
          font-size: 13px;
          line-height: 1.5;
        }

        .booking-details {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .detail-row {
          display: flex;
          gap: 12px;
          align-items: start;
        }

        .detail-label {
          font-size: 12px;
          color: #666;
          margin-bottom: 4px;
        }

        .detail-value {
          font-size: 14px;
          line-height: 1.6;
          font-weight: 500;
        }

        .save-button {
          width: 100%;
          padding: 16px;
          background: #2D5F4F;
          color: white;
          border: none;
          border-radius: 12px;
          font-size: 15px;
          font-weight: 600;
          cursor: pointer;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .save-button:hover {
          background: #3A7563;
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(45, 95, 79, 0.3);
        }

        .card-view {
          background: linear-gradient(135deg, #2D5F4F 0%, #3A7563 100%);
          color: white;
          border-radius: 16px;
          padding: 24px;
          margin-bottom: 20px;
        }

        .card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 12px;
        }

        .card-label {
          font-size: 12px;
          opacity: 0.9;
        }

        .card-number {
          font-size: 28px;
          font-weight: 700;
          letter-spacing: 2px;
          margin-bottom: 16px;
        }

        .card-type {
          font-size: 13px;
          line-height: 1.6;
          opacity: 0.95;
        }

        .family-info,
        .shop-info {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 16px;
        }

        .info-label {
          font-size: 12px;
          color: #666;
          margin-bottom: 8px;
          line-height: 1.5;
        }

        .info-value {
          font-size: 15px;
          font-weight: 600;
          color: #2D5F4F;
          line-height: 1.5;
        }

        .info-tamil {
          font-size: 14px;
          color: #666;
          margin-top: 4px;
        }

        .entitlements {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .entitlement-list {
          margin-top: 12px;
        }

        .entitlement-row {
          display: flex;
          justify-content: space-between;
          padding: 12px 0;
          border-bottom: 1px solid #f0f0f0;
        }

        .entitlement-row:last-child {
          border-bottom: none;
        }

        .entitlement-qty {
          font-weight: 600;
          color: #2D5F4F;
        }

        .view-family-button {
          width: 100%;
          padding: 16px;
          background: #2D5F4F;
          color: white;
          border: none;
          border-radius: 12px;
          font-size: 15px;
          font-weight: 600;
          cursor: pointer;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .view-family-button:hover {
          background: #3A7563;
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(45, 95, 79, 0.3);
        }

        .map-view {
          height: 300px;
          background: #e8f4f0;
          position: relative;
        }

        .map-placeholder {
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 64px;
          position: relative;
          background: linear-gradient(135deg, #e8f4f0 0%, #d4ede4 100%);
        }

        .you-marker {
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          background: #2D5F4F;
          color: white;
          padding: 8px 16px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: 600;
          white-space: nowrap;
        }

        .shop-marker {
          position: absolute;
          font-size: 12px;
          background: #6366F1;
          color: white;
          padding: 6px 12px;
          border-radius: 12px;
          font-weight: 600;
        }

        .shop-marker.shop-1 {
          top: 30%;
          left: 60%;
        }

        .shop-marker.shop-2 {
          top: 60%;
          left: 35%;
        }

        .shop-marker.shop-3 {
          top: 75%;
          left: 70%;
        }

        .shops-list {
          padding: 20px;
        }

        .list-title {
          font-size: 16px;
          font-weight: 600;
          color: #2D5F4F;
          margin-bottom: 16px;
          line-height: 1.5;
        }

        .shop-card {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 12px;
        }

        .shop-name-small {
          font-weight: 600;
          font-size: 14px;
          margin-bottom: 4px;
        }

        .registered-badge {
          display: inline-block;
          background: #2D5F4F;
          color: white;
          padding: 4px 12px;
          border-radius: 12px;
          font-size: 10px;
          font-weight: 600;
          margin-left: 8px;
        }

        .shop-address {
          font-size: 12px;
          color: #666;
          margin: 8px 0;
          line-height: 1.5;
        }

        .shop-distance {
          font-size: 12px;
          color: #2D5F4F;
          margin-bottom: 12px;
        }

        .shop-actions {
          display: flex;
          gap: 8px;
        }

        .check-stock-btn {
          flex: 1;
          padding: 12px;
          background: #2D5F4F;
          color: white;
          border: none;
          border-radius: 8px;
          font-size: 12px;
          font-weight: 600;
          cursor: pointer;
          line-height: 1.4;
          transition: all 0.3s ease;
        }

        .check-stock-btn:hover {
          background: #3A7563;
          transform: translateY(-2px);
        }

        .call-btn {
          width: 48px;
          height: 48px;
          background: #FF8C42;
          color: white;
          border: none;
          border-radius: 8px;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          transition: all 0.3s ease;
        }

        .call-btn:hover {
          background: #FF7829;
          transform: scale(1.1);
        }

        /* Delivery-specific styles */
        
        .eligibility-card {
          text-align: center;
          padding: 24px;
          background: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
          color: white;
          border-radius: 16px;
          margin-bottom: 20px;
        }

        .eligibility-icon {
          margin-bottom: 16px;
        }

        .tamil-subtitle {
          font-size: 14px;
          opacity: 0.9;
          margin-top: 8px;
        }

        .info-card {
          background: #e8f4fd;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
          display: flex;
          gap: 12px;
        }

        .info-content {
          flex: 1;
          font-size: 13px;
          line-height: 1.6;
        }

        .info-content ul {
          margin: 8px 0 0 20px;
        }

        .info-content li {
          margin: 4px 0;
        }

        .eligibility-status {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 16px;
          display: flex;
          gap: 12px;
          align-items: center;
          margin-bottom: 20px;
        }

        .success-card {
          background: #d4edda;
          border-radius: 12px;
          padding: 16px;
          display: flex;
          gap: 12px;
          margin-bottom: 20px;
          color: #155724;
        }

        .fee-card {
          background: #fff3cd;
          border-radius: 12px;
          padding: 16px;
          display: flex;
          gap: 12px;
          margin-bottom: 20px;
          color: #856404;
        }

        .delivery-benefits {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .benefit-item {
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 8px 0;
          font-size: 13px;
        }

        .address-card {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .address-header {
          display: flex;
          align-items: center;
          gap: 8px;
          font-weight: 600;
          margin-bottom: 12px;
          color: #2D5F4F;
        }

        .address-content {
          font-size: 14px;
          line-height: 1.8;
          color: #495057;
        }

        .landmark,
        .contact {
          display: flex;
          align-items: center;
          gap: 6px;
          margin-top: 8px;
          color: #6c757d;
          font-size: 13px;
        }

        .edit-address-btn {
          width: 100%;
          padding: 12px;
          background: #6366F1;
          color: white;
          border: none;
          border-radius: 8px;
          font-size: 14px;
          font-weight: 600;
          cursor: pointer;
          margin-top: 12px;
          transition: all 0.3s ease;
        }

        .edit-address-btn:hover {
          background: #5558E3;
        }

        .map-preview {
          margin-bottom: 20px;
        }

        .map-placeholder-small {
          height: 180px;
          background: linear-gradient(135deg, #e8f4f0 0%, #d4ede4 100%);
          border-radius: 12px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          gap: 8px;
          color: #2D5F4F;
        }

        .distance-info {
          font-size: 12px;
          background: white;
          padding: 6px 12px;
          border-radius: 12px;
        }

        .delivery-instructions {
          margin-bottom: 20px;
        }

        .instructions-input {
          width: 100%;
          padding: 12px;
          border: 2px solid #e0e0e0;
          border-radius: 8px;
          font-size: 13px;
          font-family: inherit;
          resize: vertical;
          margin-top: 8px;
        }

        .instructions-input:focus {
          outline: none;
          border-color: #6366F1;
        }

        .delivery-dates-list {
          display: flex;
          flex-direction: column;
          gap: 12px;
        }

        .delivery-date-card {
          padding: 16px;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          background: white;
          cursor: pointer;
          transition: all 0.3s ease;
          text-align: left;
        }

        .delivery-date-card:hover:not(.disabled) {
          border-color: #6366F1;
          transform: translateX(4px);
        }

        .delivery-date-card.selected {
          background: #f0f1ff;
          border-color: #6366F1;
        }

        .delivery-date-card.disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .date-card-header {
          display: flex;
          align-items: center;
          gap: 12px;
          font-weight: 600;
          margin-bottom: 8px;
        }

        .date-text {
          flex: 1;
        }

        .date-card-info {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 12px;
          color: #666;
        }

        .route-info {
          display: flex;
          align-items: center;
          gap: 6px;
        }

        .available-tag {
          background: #d4edda;
          color: #155724;
          padding: 4px 8px;
          border-radius: 6px;
          font-size: 11px;
          font-weight: 600;
        }

        .full-tag {
          background: #f8d7da;
          color: #721c24;
          padding: 4px 8px;
          border-radius: 6px;
          font-size: 11px;
          font-weight: 600;
        }

        .delivery-time-slots {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 12px;
        }

        .delivery-slot-card {
          padding: 16px;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          background: white;
          cursor: pointer;
          transition: all 0.3s ease;
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 12px;
          position: relative;
        }

        .delivery-slot-card:hover {
          border-color: #6366F1;
        }

        .delivery-slot-card.selected {
          background: #f0f1ff;
          border-color: #6366F1;
        }

        .slot-details {
          text-align: center;
        }

        .slot-details strong {
          display: block;
          margin-bottom: 4px;
        }

        .slot-details span {
          font-size: 12px;
          color: #666;
        }

        .delivery-note {
          background: #e8f4fd;
          padding: 12px;
          border-radius: 8px;
          display: flex;
          gap: 10px;
          font-size: 12px;
          line-height: 1.6;
          margin: 20px 0;
        }

        .review-section {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 16px;
        }

        .review-header {
          display: flex;
          align-items: center;
          gap: 8px;
          font-weight: 600;
          color: #2D5F4F;
          margin-bottom: 12px;
        }

        .review-items,
        .review-content {
          font-size: 14px;
          line-height: 1.8;
        }

        .review-item {
          display: flex;
          justify-content: space-between;
          padding: 8px 0;
          border-bottom: 1px solid #f0f0f0;
        }

        .review-item:last-child {
          border-bottom: none;
        }

        .landmark-review,
        .route-review {
          color: #6c757d;
          font-size: 13px;
          margin-top: 4px;
        }

        .review-section.payment {
          background: #f8f9fa;
        }

        .payment-breakdown {
          display: flex;
          flex-direction: column;
          gap: 8px;
        }

        .payment-row {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 14px;
        }

        .payment-row.total {
          padding-top: 8px;
          border-top: 2px solid #dee2e6;
          font-size: 16px;
          margin-top: 4px;
        }

        .terms-section {
          background: #fff3cd;
          padding: 16px;
          border-radius: 12px;
          display: flex;
          gap: 12px;
          margin-bottom: 20px;
        }

        .terms-content {
          font-size: 12px;
          line-height: 1.6;
        }

        .terms-content ul {
          margin: 8px 0 0 16px;
        }

        .terms-content li {
          margin: 4px 0;
        }

        .confirmation-icon {
          text-align: center;
          margin: 20px 0;
          color: #6366F1;
        }

        .order-id-card {
          background: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
          color: white;
          border-radius: 16px;
          padding: 24px;
          text-align: center;
          margin-bottom: 20px;
        }

        .order-label {
          font-size: 13px;
          opacity: 0.9;
          margin-bottom: 8px;
        }

        .order-number {
          font-size: 36px;
          font-weight: 700;
          letter-spacing: 1px;
        }

        .delivery-details-card {
          background: #f8f9fa;
          border-radius: 12px;
          padding: 20px;
          margin-bottom: 20px;
        }

        .detail-section {
          display: flex;
          gap: 12px;
          padding: 12px 0;
          border-bottom: 1px solid #e0e0e0;
        }

        .detail-section:last-child {
          border-bottom: none;
        }

        .detail-section strong {
          display: block;
          margin-bottom: 4px;
          color: #2D5F4F;
        }

        .detail-section p {
          font-size: 13px;
          color: #495057;
          margin: 2px 0;
        }

        .next-steps-card {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .steps-header {
          font-weight: 600;
          margin-bottom: 12px;
          color: #2D5F4F;
        }

        .step-item {
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 8px 0;
          font-size: 13px;
        }

        .action-buttons {
          display: flex;
          gap: 12px;
        }

        .secondary-btn {
          flex: 1;
          padding: 16px;
          background: white;
          color: #2D5F4F;
          border: 2px solid #2D5F4F;
          border-radius: 12px;
          font-size: 14px;
          font-weight: 600;
          cursor: pointer;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .secondary-btn:hover {
          background: #f8f9fa;
        }

        .primary-btn {
          flex: 1;
          padding: 16px;
          background: #6366F1;
          color: white;
          border: none;
          border-radius: 12px;
          font-size: 14px;
          font-weight: 600;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          gap: 8px;
          line-height: 1.5;
          transition: all 0.3s ease;
        }

        .primary-btn:hover {
          background: #5558E3;
          transform: translateY(-2px);
        }

        .tracking-header {
          display: flex;
          align-items: center;
          gap: 16px;
          background: #f8f9fa;
          padding: 20px;
          border-radius: 12px;
          margin-bottom: 20px;
        }

        .tracking-status {
          color: #6366F1;
          font-weight: 600;
          margin-top: 4px;
        }

        .tracking-map {
          margin-bottom: 20px;
        }

        .map-tracking-view {
          height: 240px;
          background: linear-gradient(135deg, #e8f4f0 0%, #d4ede4 100%);
          border-radius: 12px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          gap: 16px;
          color: #2D5F4F;
          position: relative;
        }

        .tracking-pulse {
          position: absolute;
          width: 80px;
          height: 80px;
          border: 3px solid #6366F1;
          border-radius: 50%;
          animation: pulse 2s ease-out infinite;
        }

        @keyframes pulse {
          0% {
            transform: scale(1);
            opacity: 1;
          }
          100% {
            transform: scale(1.5);
            opacity: 0;
          }
        }

        .tracking-info {
          background: white;
          padding: 8px 16px;
          border-radius: 20px;
          font-size: 13px;
          font-weight: 600;
        }

        .timeline {
          margin-bottom: 20px;
        }

        .timeline-item {
          display: flex;
          gap: 16px;
          padding: 16px 0;
          position: relative;
        }

        .timeline-item:not(:last-child)::after {
          content: '';
          position: absolute;
          left: 11px;
          top: 40px;
          width: 2px;
          height: calc(100% - 16px);
          background: #e0e0e0;
        }

        .timeline-item.completed::after {
          background: #28a745;
        }

        .timeline-item.active::after {
          background: #6366F1;
        }

        .timeline-dot {
          width: 24px;
          height: 24px;
          border-radius: 50%;
          background: #e0e0e0;
          flex-shrink: 0;
          margin-top: 2px;
        }

        .timeline-item.completed .timeline-dot {
          background: #28a745;
        }

        .timeline-item.active .timeline-dot {
          background: #6366F1;
        }

        .timeline-content {
          flex: 1;
        }

        .timeline-content strong {
          display: block;
          margin-bottom: 4px;
          color: #212529;
        }

        .timeline-content span {
          font-size: 12px;
          color: #6c757d;
        }

        .delivery-agent {
          display: flex;
          align-items: center;
          gap: 8px;
          margin-top: 8px;
          padding: 8px 12px;
          background: #f8f9fa;
          border-radius: 8px;
          font-size: 12px;
        }

        .delivery-route-info {
          background: white;
          border: 2px solid #e0e0e0;
          border-radius: 12px;
          padding: 16px;
          margin-bottom: 20px;
        }

        .route-header {
          display: flex;
          align-items: center;
          gap: 8px;
          font-weight: 600;
          color: #2D5F4F;
          margin-bottom: 16px;
        }

        .route-stats {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 12px;
        }

        .stat {
          text-align: center;
          padding: 12px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .stat strong {
          display: block;
          font-size: 20px;
          color: #6366F1;
          margin-bottom: 4px;
        }

        .stat span {
          font-size: 11px;
          color: #6c757d;
        }

        .refresh-btn {
          width: 100%;
          padding: 16px;
          background: #6366F1;
          color: white;
          border: none;
          border-radius: 12px;
          font-size: 15px;
          font-weight: 600;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
          gap: 8px;
          transition: all 0.3s ease;
        }

        .refresh-btn:hover {
          background: #5558E3;
          transform: translateY(-2px);
        }

        @media (max-width: 480px) {
          .screen {
            border-radius: 0;
            height: 100vh;
            max-height: none;
          }

          .app-container {
            padding: 0;
          }
        }
      `}</style>
    </div>
  );
}
