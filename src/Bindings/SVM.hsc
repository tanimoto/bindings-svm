#include <bindings.dsl.h>
#include <svm.h>
#include <svm-extra.h>

module Bindings.SVM where
#strict_import

-- libsvm_version
-- globalvar libsvm_version, IO CInt

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

-- svm_model -- requires svm-extra.h
#starttype struct svm_model
#field param , <svm_parameter>
#field nr_class , CInt
#field l , CInt
#field SV , Ptr (Ptr <svm_node>)
#field sv_coef , Ptr (Ptr CDouble)
#field rho , Ptr CDouble
#field probA , Ptr CDouble
#field probB , Ptr CDouble
#field label , Ptr CInt
#field nSV , Ptr CInt
#field free_sv , CInt
#stoptype

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
#ccall svm_destroy_model , Ptr <svm_model> -> IO ()
#ccall svm_destroy_param , Ptr <svm_parameter> -> IO ()

-- checking
#ccall svm_check_parameter , Ptr <svm_problem> -> Ptr <svm_parameter> -> IO CString
#ccall svm_check_probability_model , Ptr <svm_model> -> IO CInt

-- printing
#ccall svm_print_string , FunPtr (CString -> IO ())
