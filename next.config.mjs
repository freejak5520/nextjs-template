/** @type {import('next').NextConfig} */
const nextConfig = {
  compiler: {
    reactRemoveProperties:
      process.env.NODE_ENV === "production"
        ? { properties: ["^data-test.*$"] }
        : false,
  },
};

export default nextConfig;
