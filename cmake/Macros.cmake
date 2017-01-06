# Include Headers
MACRO(ADD_HEADERS module_name module_headers)
	STRING(TOUPPER ${module_name} mod_name)
	SET(VARIABLE_NAME "PROJECT_${mod_name}_HEADERS")

	SET(${VARIABLE_NAME} "${module_headers}")
ENDMACRO()

# Include Sources
MACRO(ADD_SOURCES module_name module_sources)
	STRING(TOUPPER ${module_name} mod_name)
	SET(VARIABLE_NAME "PROJECT_${mod_name}_SOURCES")

	# Prepend the module name before the files
	SET(mod_sources_ ${module_sources})
	SEPARATE_ARGUMENTS(mod_sources_)
	SET(mod_sources "")

	FOREACH(f ${mod_sources_})
		IF(mod_sources STREQUAL "")
			SET(mod_sources "${module_name}/${f}")
		ELSE()
			SET(mod_sources "${mod_sources} ${module_name}/${f}")
		ENDIF()
	ENDFOREACH()

	SET(${VARIABLE_NAME} "${mod_sources}")

	IF(DEFINED ${VARIABLE_NAME})
		#IF(PROJECT_SOURCES STREQUAL "")
		#	SET(PROJECT_SOURCES "${${VARIABLE_NAME}}" PARENT_SCOPE)
		#ELSE()
		#	SET(PROJECT_SOURCES "${PROJECT_SOURCES} ${${VARIABLE_NAME}}" PARENT_SCOPE)
		#ENDIF()

		ADD_LIBRARY(${module_name} SHARED ${module_sources})

		IF(PROJECT_LINK_LIBRARIES STREQUAL "")
			SET(PROJECT_LINK_LIBRARIES "${module_name}" PARENT_SCOPE)
		ELSE()
			SET(PROJECT_LINK_LIBRARIES "${PROJECT_LINK_LIBRARIES} ${module_name}" PARENT_SCOPE)
		ENDIF()
	ENDIF()
ENDMACRO()
