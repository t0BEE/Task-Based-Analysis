#include <hpx/hpx_init.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>
#include <hpx/include/actions.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/util.hpp>
#include <chrono>

long long add(hpx::future<long long> n1, hpx::future<long long> n2) {
    return n1.get() + n2.get();
}

struct when_all_wrapper {
    typedef hpx::util::tuple<
            hpx::future<long long>
          , hpx::future<long long> > data_type;

    long long operator()(
        hpx::future<data_type> data
    ) const
    {
        data_type v = data.get();
        return hpx::util::get<0>(v).get() + hpx::util::get<1>(v).get();
    }
};

hpx::future<long long> fibonacci_future(long long n) {
    if (n < 2)
        return hpx::make_ready_future(n);

    hpx::future<long long> f = hpx::async(&fibonacci_future, n-1);
    hpx::future<long long> r = fibonacci_future(n-2);

    return hpx::async(&add, std::move(f), std::move(r));
}

hpx::future<long long> fibonacci(long long input) {
	if (input < 2) {
                return hpx::make_ready_future(input);
        }
	hpx::future<long long> n1 = hpx::async(fibonacci, input - 1);
	hpx::future<long long> n2 = hpx::async(fibonacci, input - 2);

	return hpx::when_all(n1, n2).then(when_all_wrapper());
}

int hpx_main(hpx::program_options::variables_map& vm) {
    // extract command line arguments
    int fibNumber = vm["n-value"].as<int>();
    int debug = vm["debug"].as<int>();

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    long long result = fibonacci((long long) fibNumber).get();

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
