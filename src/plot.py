import csv
import matplotlib.pyplot as plt

time = []
position = []
velocity = []

with open('./build/simulation_data.csv', 'r') as file:
    reader = csv.reader(file)
    for row in reader:
        time.append(float(row[0]))
        position.append(float(row[1]))
        velocity.append(float(row[2]))

plt.plot(time, position, label='Position')
plt.plot(time, velocity, label='Velocity')
plt.xlabel('Time')
plt.ylabel('Value')
plt.legend()
plt.title('Simulation Data')

# Save the plot to an image file
plt.savefig('./build/simulation_plot.png')

# Close the plot to free up resources
plt.close()
    