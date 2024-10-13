import logging
import time

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(message)s')

def log_messages():
    while True:
        logging.info("This is a log message.")
        time.sleep(2)  # Wait for 2 seconds before logging the next message

if __name__ == "__main__":
    log_messages()

