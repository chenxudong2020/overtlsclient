#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef enum ArgVerbosity {
  Off = 0,
  Error,
  Warn,
  Info,
  Debug,
  Trace,
} ArgVerbosity;

/**
 * # Safety
 *
 * Run the overtls client with config file.
 */
int over_tls_client_run(const char *config_path,
                        enum ArgVerbosity verbosity,
                        void (*callback)(int, void*),
                        void *ctx);

/**
 * # Safety
 *
 * Shutdown the client.
 */
int over_tls_client_stop(void);

/**
 * # Safety
 *
 * set dump log info callback.
 */
void overtls_set_log_callback(void (*callback)(enum ArgVerbosity, const char*, void*), void *ctx);
