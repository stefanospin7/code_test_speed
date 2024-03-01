import time
import multiprocessing


# single core
'''
def benchmark_nested_loops(num_iterations):
    start_time = time.time()

    # Nested loops
    for _ in range(num_iterations):
        for _ in range(num_iterations):
            pass

    end_time = time.time()
    execution_time = end_time - start_time

    return execution_time

num_iterations = 50000
execution_time = benchmark_nested_loops(num_iterations)
print(f"Execution time for {num_iterations} iterations: {execution_time} seconds")
'''

# multi core

def benchmark_nested_loops(num_iterations):
    # Nested loops
    for _ in range(num_iterations):
        for _ in range(num_iterations):
            pass

def parallel_benchmark(num_iterations, num_processes):
    start_time = time.time()
    pool = multiprocessing.Pool(processes=num_processes)
    results = [pool.apply_async(benchmark_nested_loops, (num_iterations // num_processes,)) for _ in range(num_processes)]
    pool.close()
    pool.join()
    end_time = time.time()

    total_execution_time = end_time - start_time
    return total_execution_time

num_iterations = 200000
num_processes = multiprocessing.cpu_count()  # Use all available CPU cores
execution_time = parallel_benchmark(num_iterations, num_processes)
print(f"Execution time for {num_iterations} iterations with {num_processes} processes: {execution_time} seconds")