package com.demo;

/**
 * GraalVM POC application.
 *
 * Execution modes:
 * 1. Gradle/IntelliJ Run  -> JVM execution with JIT compilation.
 * 2. GraalVM native image -> AOT compiled native executable.
 */
public class App {

    private static final int ROUNDS = 6;
    private static final int PRIME_LIMIT = 60_000;
    private static final int MATRIX_SIZE = 2_200;
    private static final int FIBONACCI_N = 45;

    public static void main(String[] args) {
        String mode = detectExecutionMode();

        System.out.println("===========================================");
        System.out.println(" Java 21 + Gradle + GraalVM POC");
        System.out.println("===========================================");
        System.out.println("Execution Mode : " + mode);
        System.out.println("OS             : " + System.getProperty("os.name"));
        System.out.println("Java Version   : " + System.getProperty("java.version"));
        System.out.println("Java Vendor    : " + System.getProperty("java.vendor"));
        System.out.println("Available CPUs : " + Runtime.getRuntime().availableProcessors());
        System.out.println("-------------------------------------------");
        System.out.println("Running CPU-heavy workload...");

        long startTime = System.nanoTime();

        long finalResult = runCpuHeavyWorkload();

        long endTime = System.nanoTime();
        double executionTimeMs = (endTime - startTime) / 1_000_000.0;

        System.out.println("-------------------------------------------");
        System.out.println("Final Result   : " + finalResult);
        System.out.printf("Execution Time : %.3f ms%n", executionTimeMs);
        System.out.println("Status         : Completed successfully");
        System.out.println("===========================================");
    }

    private static String detectExecutionMode() {
        String nativeImageMode = System.getProperty("org.graalvm.nativeimage.imagecode");

        if (nativeImageMode != null) {
            return "AOT Native Image (GraalVM compiled executable)";
        }

        return "JVM Mode (JIT compilation enabled at runtime)";
    }

    private static long runCpuHeavyWorkload() {
        long result = 0;

        for (int round = 1; round <= ROUNDS; round++) {
            result += calculatePrimeSum(PRIME_LIMIT);
            result += fibonacciLoop(FIBONACCI_N);
            result += nestedLoopCalculation(MATRIX_SIZE);
            result ^= checksumRound(result, round);
        }

        return result;
    }

    private static long calculatePrimeSum(int limit) {
        long sum = 0;

        for (int number = 2; number <= limit; number++) {
            if (isPrime(number)) {
                sum += number;
            }
        }

        return sum;
    }

    private static boolean isPrime(int number) {
        if (number < 2) {
            return false;
        }

        if (number == 2) {
            return true;
        }

        if (number % 2 == 0) {
            return false;
        }

        for (int divisor = 3; divisor * divisor <= number; divisor += 2) {
            if (number % divisor == 0) {
                return false;
            }
        }

        return true;
    }

    private static long fibonacciLoop(int n) {
        long first = 0;
        long second = 1;

        for (int i = 2; i <= n; i++) {
            long next = first + second;
            first = second;
            second = next;
        }

        return second;
    }

    private static long nestedLoopCalculation(int size) {
        long total = 0;

        for (int row = 0; row < size; row++) {
            for (int col = 0; col < size; col++) {
                total += ((long) row * col) % 97;
                total ^= (row + col) % 31;
            }
        }

        return total;
    }

    private static long checksumRound(long value, int round) {
        long checksum = value;

        for (int i = 1; i <= 10_000; i++) {
            checksum = (checksum * 31 + i + round) % 1_000_000_007L;
        }

        return checksum;
    }
}
