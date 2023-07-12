import matplotlib.pyplot as plt

# Ask for user input
weight = float(input("Enter weight in kilograms: "))
height = float(input("Enter height in meters: "))
age = int(input("Enter age in years: "))
sex = input("Enter sex (M/F): ")

# Calculate Body Mass Index (BMI)
bmi = weight / (height ** 2)

# Calculate Basal Metabolic Rate (BMR) for different sexes
if sex.upper() == "M":
    bmr = 10 * weight + 6.25 * height * 100 - 5 * age + 5
elif sex.upper() == "F":
    bmr = 10 * weight + 6.25 * height * 100 - 5 * age - 161
else:
    print("Invalid sex input. Please enter 'M' for male or 'F' for female.")
    exit()

# Calculate Resting Heart Rate (RHR)
rhr = int(input("Enter resting heart rate (beats per minute): "))

# Calculate Waist-to-Hip Ratio (WHR)
waist = float(input("Enter waist circumference in centimeters: "))
hip = float(input("Enter hip circumference in centimeters: "))
whr = waist / hip

# Determine BMI range
bmi_range = ""
if bmi < 18.5:
    bmi_range = "Underweight"
elif 18.5 <= bmi < 25.0:
    bmi_range = "Healthy Weight"
elif 25.0 <= bmi < 30.0:
    bmi_range = "Overweight"
else:
    bmi_range = "Obese"

# Print the calculated parameters
print("Body Mass Index (BMI): {:.2f}".format(bmi))
print("BMI Range: {}".format(bmi_range))
print("Basal Metabolic Rate (BMR): {:.2f} calories per day".format(bmr))
print("Resting Heart Rate (RHR): {} beats per minute".format(rhr))
print("Waist-to-Hip Ratio (WHR): {:.2f}".format(whr))

# Visualize the results
parameters = ["BMI", "BMR", "RHR", "WHR"]
values = [bmi, bmr, rhr, whr]

plt.bar(parameters, values)
plt.xlabel("Health Parameters")
plt.ylabel("Values")
plt.title("Health Parameter Analysis")
plt.show()
