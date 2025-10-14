// Test TypeScript file to verify LSP features
// Try these:
// 1. Hover over 'greeting' and press 'K' - should show type info
// 2. Press 'gd' on 'greeting' - should go to definition
// 3. Uncomment the error line to see diagnostics

const greeting: string = "Hello, TypeScript!";

function sayHello(name: string): string {
  return `${greeting}, ${name}!`;
}

const result = sayHello("World");
console.log(result);

// Uncomment this to see LSP error detection:
// const error: number = "this should error";

