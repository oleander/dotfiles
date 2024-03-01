import psutil
import time
from datetime import datetime

# Adjust the sleep time to how often you want to check the memory/swap usage (in seconds)
sleep_time = 60

# Log file to store the usage data
log_file = '/Users/linus/memory_swap_usage_log.txt'

def log_memory_swap_usage():
    with open(log_file, 'a') as file:
        while True:
            # Get memory and swap usage details
            memory = psutil.virtual_memory()
            swap = psutil.swap_memory()

            # Format current time
            timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

            # Log the current memory and swap usage
            log_message = f"{timestamp}, Memory Usage: {memory.percent}%, Available Memory: {memory.available/1024**3:.2f}GB, Swap Usage: {swap.percent}%, Swap Used: {swap.used/1024**3:.2f}GB\n"
            
            print(log_message)  # Print to console for real-time monitoring
            file.write(log_message)  # Write to log file

            time.sleep(sleep_time)

if __name__ == '__main__':
    log_memory_swap_usage()
