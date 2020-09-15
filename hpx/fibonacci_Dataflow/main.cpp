#include <hpx/hpx_init.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>
#include <hpx/include/actions.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/util.hpp>
#include <chrono>


hpx::future<long long> fibonacci(long long n)
{
    if (n < 2) return hpx::make_ready_future(n);

    hpx::future<long long> lhs_future = hpx::async(&fibonacci, n-1);
    hpx::future<long long> rhs_future = fibonacci(n-2);

    return
        hpx::dataflow(
            hpx::util::unwrapping(
            [](long long lhs, long long rhs)
            {
                return lhs + rhs;
            })
          , std::move(lhs_future), std::move(rhs_future)
        );
}


int hpx_main(hpx::program_options::variables_map& vm) {
    // extract command line arguments
    int fibNumber = vm["n-value"].as<int>();
    int debug = vm["debug"].as<int>();

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    long long result = fibonacci((long long)fibNumber).get();

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    if (debug) hpx::cout << "Execution time: " << duration.count() << "\n" << hpx::flush;
    else hpx::cout << duration.count() << hpx::flush;

    // output result for debugging
    if (debug) hpx::cout << result << "\n" << hpx::flush;

    // shutdown HPX environment
    return hpx::finalize();

}


int main(int argc, char *argv[]){
    // Configure application-specific options
    hpx::program_options::options_description
       desc_commandline("Usage: " HPX_APPLICATION_STRING " [options]");

    desc_commandline.add_options()
        ( "n-value",
          hpx::program_options::value<int>()->default_value(10),
          "n value for the Fibonacci function");

    desc_commandline.add_options()
        ( "debug",
          hpx::program_options::value<int>()->default_value(0),
          "provide this flag to gain more information about the execution");

    // Init and run HPX runtime environment
    return hpx::init(desc_commandline, argc, argv);
}
