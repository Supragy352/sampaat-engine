#include <stdio.h>

#define sim_file "./build/simulation_data.csv"

void writeCSV(double time, double velocity, double acceleration) {
    FILE *file = fopen(sim_file, "a");
    if (file != NULL) {
        fprintf(file, "%.2f,%.2f,%.2f\n", time, velocity, acceleration);
        fclose(file);
    } else {
        printf("Something wrong with the simulation data file.");
    }
}

int main(int argc, char const *argv[])
{
    double t = 0.0;
    float dt = 0.10f;

    float velocity = 10.0f;
    float position = 0.0f;
    float force = 34.0f;
    float mass = 4.3f;
    float energy = 0.0f;

    while (t <= 10.0) {
        position = position + velocity * dt; // s(final) = s(initial) + vt
        velocity = velocity + (force/mass) * dt; // v = u + at
        energy = mass * velocity * velocity;

        t += dt;
        writeCSV(t, position, energy);
    }
    return 0;
}