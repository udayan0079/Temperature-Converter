# Temperature Converter App

**Live Test: Temperature Converter App**

A Flutter application developed to convert temperatures between Celsius and Fahrenheit with clean input validation and modern UI.

---

## 🚀 Features & Functional Requirements

1. **App UI**:
   - App title: **Temperature Converter**
   - Clean **TextField** for entering degrees (supports decimals and negative temperatures).
   - **DropdownButton** for selecting conversion type.
   - **Calculate / Convert** action button.
   - **Result** display formatted up to **2 decimal places**.

2. **Conversion Options**:
   - `Celsius to Fahrenheit (°C → °F)`
   - `Fahrenheit to Celsius (°F → °C)`

3. **Conversion Logic**:
   - **Celsius to Fahrenheit**: $F = (C \times 9/5) + 32$
   - **Fahrenheit to Celsius**: $C = (F - 32) \times 5/9$

4. **Input Validation**:
   - Displays error message when the input field is empty: `Please enter a temperature value`.
   - Displays error message when the entered value is not a valid number: `Please enter a valid number`.

---

## 🛠️ How to Run

1. Navigate to the project directory:
   ```bash
   cd tca
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

4. Run tests:
   ```bash
   flutter test
   ```
