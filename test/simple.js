import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  // Define how many virtual users (VUs) and for how long the test runs
  vus: 10,       // 10 virtual users
  duration: '30s', // Test runs for 30 seconds
};

export default function () {
  // Perform a GET request to a public test URL
  http.get('https://test.k6.io');
  
  // Pause for 1 second between requests to simulate realistic user behavior
  sleep(1);
}