"""
MÓDULO 9: REDES NEURONALES - PERCEPTRÓN DESDE CERO
===================================================

Las redes neuronales son la base del Deep Learning y la IA moderna.
En este módulo construiremos una red neuronal desde cero para entender
cómo funcionan internamente.

Perceptrón: La neurona artificial más simple
Red Neuronal: Conjunto de perceptrones conectados en capas
"""

import numpy as np
import matplotlib.pyplot as plt

# =============================================================================
# 1. PERCEPTRÓN SIMPLE
# =============================================================================

print("=" * 70)
print("1. PERCEPTRÓN SIMPLE (Single Neuron)")
print("=" * 70)

"""
Un perceptrón es una unidad de procesamiento que:
1. Recibe inputs (x₁, x₂, ..., xₙ)
2. Los multiplica por pesos (w₁, w₂, ..., wₙ)
3. Suma todo + bias (b)
4. Aplica función de activación

Matemáticamente:
y = f(w₁x₁ + w₂x₂ + ... + wₙxₙ + b)
  = f(Σ(wᵢxᵢ) + b)
  = f(w·x + b)
"""

class Perceptron:
    """Implementación de un perceptrón simple"""

    def __init__(self, n_inputs, learning_rate=0.01):
        """
        Inicializa el perceptrón.

        Parámetros:
        -----------
        n_inputs : int
            Número de features de entrada
        learning_rate : float
            Tasa de aprendizaje
        """
        # Inicializar pesos aleatoriamente (pequeños)
        self.weights = np.random.randn(n_inputs) * 0.01
        self.bias = 0
        self.learning_rate = learning_rate

    def activation(self, x):
        """
        Función de activación (escalón)
        Devuelve 1 si x >= 0, sino 0
        """
        return 1 if x >= 0 else 0

    def predict(self, X):
        """
        Realiza una predicción.

        Parámetros:
        -----------
        X : array de forma (n_inputs,)
            Input features

        Retorna:
        --------
        Predicción: 0 o 1
        """
        # Calcular suma ponderada
        z = np.dot(self.weights, X) + self.bias

        # Aplicar activación
        return self.activation(z)

    def train(self, X, y, epochs=100):
        """
        Entrena el perceptrón.

        Parámetros:
        -----------
        X : array de forma (n_samples, n_features)
            Datos de entrenamiento
        y : array de forma (n_samples,)
            Etiquetas
        epochs : int
            Número de épocas de entrenamiento
        """
        errors = []

        for epoch in range(epochs):
            total_error = 0

            for xi, target in zip(X, y):
                # Hacer predicción
                prediction = self.predict(xi)

                # Calcular error
                error = target - prediction

                # Actualizar pesos: w = w + α * error * x
                self.weights += self.learning_rate * error * xi
                self.bias += self.learning_rate * error

                total_error += abs(error)

            errors.append(total_error)

            if (epoch + 1) % 10 == 0:
                print(f"  Época {epoch + 1}/{epochs}, Error total: {total_error}")

        return errors

# Ejemplo: Puerta lógica AND
print("\nEjemplo: Aprender la puerta lógica AND")
print("=" * 70)

# Datos de la puerta AND
X_and = np.array([
    [0, 0],  # 0 AND 0 = 0
    [0, 1],  # 0 AND 1 = 0
    [1, 0],  # 1 AND 0 = 0
    [1, 1]   # 1 AND 1 = 1
])

y_and = np.array([0, 0, 0, 1])

print("Datos de entrenamiento (AND):")
for x, target in zip(X_and, y_and):
    print(f"  {x[0]} AND {x[1]} = {target}")
print()

# Crear y entrenar perceptrón
perceptron = Perceptron(n_inputs=2, learning_rate=0.1)
print("Entrenando perceptrón...")
errors = perceptron.train(X_and, y_and, epochs=20)

print(f"\nPesos finales: {perceptron.weights}")
print(f"Bias final: {perceptron.bias}")
print()

# Probar el perceptrón
print("Predicciones:")
for x, target in zip(X_and, y_and):
    pred = perceptron.predict(x)
    print(f"  {x[0]} AND {x[1]} = {pred} (esperado: {target}) {'✓' if pred == target else '✗'}")
print()

# =============================================================================
# 2. RED NEURONAL MULTICAPA DESDE CERO
# =============================================================================

print("=" * 70)
print("2. RED NEURONAL MULTICAPA (MLP)")
print("=" * 70)

"""
Una red neuronal multicapa consta de:
- Capa de entrada: Recibe los datos
- Capas ocultas: Procesan la información
- Capa de salida: Produce la predicción

Entrenamiento mediante Backpropagation:
1. Forward pass: Calcular predicción
2. Calcular error (loss)
3. Backward pass: Propagar error hacia atrás
4. Actualizar pesos
"""

def sigmoid(x):
    """Función de activación sigmoide"""
    return 1 / (1 + np.exp(-np.clip(x, -500, 500)))  # clip para estabilidad

def sigmoid_derivative(x):
    """Derivada de la sigmoide"""
    return x * (1 - x)

class NeuralNetwork:
    """Red Neuronal con una capa oculta"""

    def __init__(self, input_size, hidden_size, output_size, learning_rate=0.5):
        """
        Inicializa la red neuronal.

        Parámetros:
        -----------
        input_size : int
            Número de features de entrada
        hidden_size : int
            Número de neuronas en la capa oculta
        output_size : int
            Número de neuronas en la capa de salida
        learning_rate : float
            Tasa de aprendizaje
        """
        self.learning_rate = learning_rate

        # Inicializar pesos aleatoriamente
        # Capa entrada -> oculta
        self.weights_input_hidden = np.random.randn(input_size, hidden_size) * 0.5

        # Capa oculta -> salida
        self.weights_hidden_output = np.random.randn(hidden_size, output_size) * 0.5

        # Bias
        self.bias_hidden = np.zeros((1, hidden_size))
        self.bias_output = np.zeros((1, output_size))

    def forward(self, X):
        """
        Forward propagation

        Parámetros:
        -----------
        X : array de forma (n_samples, n_features)

        Retorna:
        --------
        output : array de forma (n_samples, output_size)
        """
        # Capa oculta
        self.hidden_input = np.dot(X, self.weights_input_hidden) + self.bias_hidden
        self.hidden_output = sigmoid(self.hidden_input)

        # Capa de salida
        self.final_input = np.dot(self.hidden_output, self.weights_hidden_output) + self.bias_output
        self.final_output = sigmoid(self.final_input)

        return self.final_output

    def backward(self, X, y):
        """
        Backward propagation (Backpropagation)

        Parámetros:
        -----------
        X : array de forma (n_samples, n_features)
        y : array de forma (n_samples, output_size)
        """
        m = X.shape[0]  # Número de ejemplos

        # Calcular error en la salida
        output_error = y - self.final_output
        output_delta = output_error * sigmoid_derivative(self.final_output)

        # Calcular error en la capa oculta
        hidden_error = output_delta.dot(self.weights_hidden_output.T)
        hidden_delta = hidden_error * sigmoid_derivative(self.hidden_output)

        # Actualizar pesos y bias
        self.weights_hidden_output += self.hidden_output.T.dot(output_delta) * self.learning_rate / m
        self.bias_output += np.sum(output_delta, axis=0, keepdims=True) * self.learning_rate / m

        self.weights_input_hidden += X.T.dot(hidden_delta) * self.learning_rate / m
        self.bias_hidden += np.sum(hidden_delta, axis=0, keepdims=True) * self.learning_rate / m

    def train(self, X, y, epochs=10000):
        """
        Entrena la red neuronal

        Parámetros:
        -----------
        X : array de forma (n_samples, n_features)
        y : array de forma (n_samples, output_size)
        epochs : int
            Número de épocas
        """
        losses = []

        for epoch in range(epochs):
            # Forward pass
            output = self.forward(X)

            # Calcular loss (MSE)
            loss = np.mean((y - output) ** 2)
            losses.append(loss)

            # Backward pass
            self.backward(X, y)

            # Imprimir progreso
            if (epoch + 1) % 1000 == 0:
                print(f"  Época {epoch + 1}/{epochs}, Loss: {loss:.6f}")

        return losses

    def predict(self, X):
        """Realiza predicciones"""
        return self.forward(X)

# Ejemplo: Puerta XOR (no linealmente separable)
print("\nEjemplo: Aprender la puerta lógica XOR")
print("=" * 70)

"""
XOR es especial porque NO es linealmente separable.
Un perceptrón simple no puede aprenderlo.
Necesitamos una red neuronal con capa oculta.
"""

# Datos XOR
X_xor = np.array([
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
])

y_xor = np.array([[0], [1], [1], [0]])

print("Datos de entrenamiento (XOR):")
for x, target in zip(X_xor, y_xor):
    print(f"  {x[0]} XOR {x[1]} = {target[0]}")
print()

# Crear red neuronal: 2 inputs -> 4 hidden -> 1 output
nn = NeuralNetwork(input_size=2, hidden_size=4, output_size=1, learning_rate=0.5)

print("Entrenando red neuronal...")
losses = nn.train(X_xor, y_xor, epochs=10000)

print("\nPredicciones:")
predictions = nn.predict(X_xor)
for x, target, pred in zip(X_xor, y_xor, predictions):
    pred_class = 1 if pred[0] > 0.5 else 0
    print(f"  {x[0]} XOR {x[1]} = {pred[0]:.4f} → {pred_class} (esperado: {target[0]}) {'✓' if pred_class == target[0] else '✗'}")
print()

# =============================================================================
# 3. VISUALIZACIONES
# =============================================================================

print("=" * 70)
print("3. VISUALIZACIONES")
print("=" * 70)

fig, axes = plt.subplots(1, 3, figsize=(18, 5))

# 1. Convergencia del perceptrón (AND)
ax1 = axes[0]
ax1.plot(errors, 'b-', linewidth=2)
ax1.set_xlabel('Época', fontsize=12)
ax1.set_ylabel('Error Total', fontsize=12)
ax1.set_title('Convergencia del Perceptrón (AND)', fontsize=14, fontweight='bold')
ax1.grid(True, alpha=0.3)

# 2. Convergencia de la red neuronal (XOR)
ax2 = axes[1]
ax2.plot(losses, 'r-', linewidth=2)
ax2.set_xlabel('Época', fontsize=12)
ax2.set_ylabel('Loss (MSE)', fontsize=12)
ax2.set_title('Convergencia de la Red Neuronal (XOR)', fontsize=14, fontweight='bold')
ax2.grid(True, alpha=0.3)
ax2.set_yscale('log')  # Escala logarítmica para ver mejor

# 3. Frontera de decisión XOR
ax3 = axes[2]

# Crear malla
h = 0.01
x_min, x_max = -0.5, 1.5
y_min, y_max = -0.5, 1.5
xx, yy = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))

# Predecir para cada punto de la malla
Z = nn.predict(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

# Plotear
ax3.contourf(xx, yy, Z, levels=20, cmap='RdYlBu', alpha=0.6)
ax3.scatter(X_xor[:, 0], X_xor[:, 1], c=y_xor.ravel(), s=200, cmap='RdYlBu',
            edgecolors='black', linewidth=2)
ax3.set_xlabel('X1', fontsize=12)
ax3.set_ylabel('X2', fontsize=12)
ax3.set_title('Frontera de Decisión (XOR)', fontsize=14, fontweight='bold')
ax3.grid(True, alpha=0.3)

# Añadir etiquetas
for x, y_val in zip(X_xor, y_xor):
    ax3.annotate(f'{int(y_val[0])}', xy=(x[0], x[1]),
                xytext=(0, 10), textcoords='offset points',
                fontsize=12, fontweight='bold', color='white',
                bbox=dict(boxstyle='round,pad=0.3', facecolor='black', alpha=0.7))

plt.tight_layout()
plt.savefig('neural_network_desde_cero.png', dpi=150, bbox_inches='tight')
print("✓ Visualizaciones guardadas como 'neural_network_desde_cero.png'")
plt.close()

# =============================================================================
# 4. ARQUITECTURA DE LA RED NEURONAL
# =============================================================================

print("\n" + "=" * 70)
print("4. ARQUITECTURA DE LA RED NEURONAL")
print("=" * 70)

print("\nRed Neuronal para XOR:")
print("""
    Capa de Entrada (2 neuronas)
           ↓
    Capa Oculta (4 neuronas)
           ↓
    Capa de Salida (1 neurona)

    Total de parámetros:
    - Pesos entrada→oculta: 2 × 4 = 8
    - Bias oculta: 4
    - Pesos oculta→salida: 4 × 1 = 4
    - Bias salida: 1
    - TOTAL: 17 parámetros entrenables
""")

total_params = (
    nn.weights_input_hidden.size +
    nn.bias_hidden.size +
    nn.weights_hidden_output.size +
    nn.bias_output.size
)

print(f"Parámetros totales: {total_params}")
print()

print("=" * 70)
print("¡Has completado el módulo de Perceptrón y Redes Neuronales!")
print("=" * 70)
print("\nResumen de lo aprendido:")
print("✓ Perceptrón simple")
print("✓ Red neuronal multicapa (MLP)")
print("✓ Forward propagation")
print("✓ Backward propagation (Backpropagation)")
print("✓ Función de activación (sigmoide)")
print("✓ Implementación desde cero")
print("✓ Puerta XOR con red neuronal")
print("\n➡️ Próximo paso: Usar TensorFlow/Keras para redes más complejas")
