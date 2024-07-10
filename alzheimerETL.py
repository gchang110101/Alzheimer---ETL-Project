from sqlalchemy import create_engine
import logging as log
import pandas as pd
import numpy as np

alzheimer_query_file = 'alzheimer_query.sql'
server = 'localhost'
driver = 'ODBC Driver 17 for SQL Server'
database = 'ALZHEIMER_DB'

log.basicConfig(filename='etl.log', level=log.INFO,
 format='%(asctime)s:%(levelname)s:%(message)s')

try:
    
    # cadena de conexion para la base de datos con sql alchemy (engine)
    connection_string = f'mssql+pyodbc://{server}/{database}?driver={driver}&trusted_connection=yes'
    engine = create_engine(connection_string)

    with open(alzheimer_query_file, 'r') as file:
        query = file.read()

    # armar el data frame con la informacion de la base de datos
    data_frame = pd.read_sql(query, engine)

    # cantidad de filas en el data frame con el metodo shape (debería de ser 284143 originalmente)
    num_rows = data_frame.shape[0]

    #cantidad de columnas en el data frame con el metodo shape (debería de ser 31 originalmente)
    num_cols = data_frame.shape[1]

    #loggeo de info de carga de datos exitosa, y cantidad de filas y columnas
    log_msg = log.info(f'carga de datos exitosa al data frame --> hay {num_rows} filas, y {num_cols} columnas')
    
    #testing
    #print(data_frame.head())
    print(num_rows)
    print(num_cols)
    print(list(data_frame.columns))

    #eliminar columnas que no van a ser utilizadas
    data_frame = data_frame.drop(
        [
            'Datasource',
            'Data_Value_Footnote', 
            'Data_Value_Footnote_Symbol',
            'StratificationCategory1',
            'Data_Value_Alt'
        ], 
        axis=1)
    
    log.info(f'columnas eliminadas: Datasource, Data_Value_Footnote, Data_Value_Footnote_Symbol, StratificationCategory1, Data_Value_Alt')

    #renombrar columnas (lo dejé asi para que sea mas facil agregas mas columnas a renombrar)
    data_frame = data_frame.rename(
        columns = {
                    'Stratification1': 'Age Group'
        }
    )

    #transformaciones de columnas=========================================================

    #transformación de columna Age Group:
    data_frame['Age Group'] = np.where(
                                        data_frame['Age Group'] == 'Overall', 'Overall', 
                                        data_frame['Age Group']
                                                .str.replace(' years', '')
                                                .str.replace('65 or older', '>=65'))


    #transformación de geolocation -- separar longitud y latitud hacia dos columnas (si no existen, se crean)
    data_frame[['Longitud', 'Latitud']] = data_frame['Geolocation'].str.extract(r'POINT \((.*?) (.*?)\)', expand=True)
    data_frame = data_frame.drop('Geolocation', axis=1)

    #limpiado de datos vacios para la columna Data_Value
    data_frame['Data_Value'] = data_frame['Data_Value'].fillna('N/A')
    
    #=======================================================================================

    #testing
    #print(data_frame.head())
    num_cols = data_frame.shape[1]
    print(num_cols)
    print(list(data_frame.columns))

    #imprimir SAMPLES para la transformacion de geolocation
    #print(data_frame['Geolocation'].sample(3))
    #print(data_frame['Longitud'].sample(3))
    #print(data_frame['Latitud'].sample(3))
    #print(data_frame['Data_Value'].sample(10))

    #crear tabla de staging en al base de datos segun df transformado
    data_frame = data_frame.head(100)
    data_frame.to_sql('AlzheimerStaging', engine, if_exists='replace', index=False)

    #borrar data_frame
    del data_frame

except Exception as ex:
    print("Hubo un error durante la conexion o ejecución del script SQL. MENSAJE -->: {}".format(ex))
    log.error(f'Hubo un error al tratar de cargar los datos al data frame')
    raise

finally:
    engine.dispose
    print("Conexión cerrada")
