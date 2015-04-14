import sys
import hmac
import hashlib

def main():
    instance_id=str(sys.argv[1])
    secret=str(sys.argv[2])

    expected_signature = hmac.new(secret, instance_id, hashlib.sha256).hexdigest()
    print expected_signature
   
if __name__ == "__main__":
    main()

