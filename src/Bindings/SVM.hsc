{-|
For a high-level description of the C API, refer to the README file
included in the libsvm archive, available for download at
<http://www.csie.ntu.edu.tw/~cjlin/libsvm/>.
-}

#include <bindings.dsl.h>
#include <svm.h>

module Bindings.SVM where
#strict_import

-- libsvm_version
#globalvar libsvm_version , CInt

-- svm_node
#starttype struct svm_node
#field index , CInt
#field value , CDouble
#stoptype

-- svm_problem
#starttype struct svm_problem
#field l , CInt
#field y , Ptr CDouble
#field x , Ptr (Ptr <svm_node>)
#stoptype

-- svm_type
#num C_SVC
#num NU_SVC
#num ONE_CLASS
#num EPSILON_SVR
#num NU_SVR

-- kernel_type
#num LINEAR
#num POLY
#num RBF
#num SIGMOID
#num PRECOMPUTED

-- svm_parameter
#starttype struct svm_parameter
#field svm_type , CInt
#field kernel_type , CInt
#field degree , CInt
#field gamma , CDouble
#field coef0 , CDouble

#field cache_size , CDouble
#field eps , CDouble
#field C , CDouble

#field nr_weight , CInt
#field weight_label , Ptr CInt
#field weight , Ptr CDouble
#field nu , CDouble

#field p , CDouble
#field shrinking , CInt
#field probability , CInt
#stoptype

-- svm_model
#opaque_t svm_model

-- training
#ccall svm_train , Ptr <svm_problem> -> Ptr <svm_parameter> -> IO (Ptr <svm_model>)

-- cross validation
#ccall svm_cross_validation , Ptr <svm_problem> -> Ptr <svm_parameter> -> CInt -> Ptr CDouble -> IO ()

-- saving models
#ccall svm_save_model , CString -> Ptr <svm_model> -> IO ()

-- loading models
#ccall svm_load_model , CString -> IO (Ptr <svm_model>)

-- getting properties
#ccall svm_get_svm_type , Ptr <svm_model> -> IO CInt
#ccall svm_get_nr_class , Ptr <svm_model> -> IO CInt
#ccall svm_get_labels , Ptr <svm_model> -> Ptr CInt -> IO ()
#ccall svm_get_svr_probability , Ptr <svm_model> -> IO CDouble

-- predictions
#ccall svm_predict_values , Ptr <svm_model> -> Ptr <svm_node> -> Ptr CDouble -> IO ()
#ccall svm_predict , Ptr <svm_model> -> Ptr <svm_node> -> IO CDouble
#ccall svm_predict_probability , Ptr <svm_model> -> Ptr <svm_node> -> Ptr CDouble -> IO CDouble

-- destroying
#ccall svm_free_model_content, Ptr <svm_model> -> IO ()
#ccall svm_free_and_destroy_model , Ptr (Ptr <svm_model>) -> IO ()
#ccall svm_destroy_param , Ptr <svm_parameter> -> IO ()

-- checking
#ccall svm_check_parameter , Ptr <svm_problem> -> Ptr <svm_parameter> -> IO CString
#ccall svm_check_probability_model , Ptr <svm_model> -> IO CInt

-- printing
#ccall svm_set_print_string_function , FunPtr (CString -> IO ())
