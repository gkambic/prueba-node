// Función para convertir la fecha de 'YYYY-MM-DD' a 'dd-MM-yyyy'
export const formatDate = (dateStr) => {
    const [year, month, day] = dateStr.split('-');
    return `${day}-${month}-${year}`;
  };