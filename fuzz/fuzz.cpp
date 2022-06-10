#include <libqalculate/Calculator.h>
static bool initialized = false;

bool InitCalculator(){
    new Calculator();
    CALCULATOR->loadExchangeRates();
    CALCULATOR->loadGlobalDefinitions();
    CALCULATOR->loadLocalDefinitions();

    return true;
}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
    if (!initialized) {
        initialized = InitCalculator();
    }

    std::string input(reinterpret_cast<const char *>(Data), Size);

    EvaluationOptions eo;
    MathStructure result;
    CALCULATOR->calculate(&result, input, 2000, eo);

    return 0;
}