void main() {
    // Define the gradient colors and their corresponding positions
    vec4 colors[NUM_COLORS] = u_colors;
    vec2 positions[NUM_COLORS] = u_positions;

    // Calculate the distance from the current pixel to each gradient position
    float distances[NUM_COLORS];
    for (int i = 0; i < NUM_COLORS; i++) {
        distances[i] = distance(uv, positions[i]);
    }

    // Find the two closest gradient positions to the current pixel
    int minIndex = 0;
    for (int i = 1; i < NUM_COLORS; i++) {
        if (distances[i] < distances[minIndex]) {
            minIndex = i;
        }
    }
    int maxIndex = 0;
    for (int i = 1; i < NUM_COLORS; i++) {
        if (distances[i] > distances[maxIndex]) {
            maxIndex = i;
        }
    }

    // Interpolate the color based on the distance to the two closest gradient positions
    vec4 color1 = colors[minIndex];
    vec4 color2 = colors[maxIndex];
    float t = (distances[maxIndex] - distances[minIndex]) / (distances[maxIndex] - distances[minIndex] + 0.001);
    vec4 finalColor = mix(color1, color2, t);

    // Output the final color
    gl_FragColor = finalColor;
}
