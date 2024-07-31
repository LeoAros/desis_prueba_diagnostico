document.addEventListener("DOMContentLoaded", function (event) {
    let communes

    //Se obtienen los elementos
    const selectCandidate = document.getElementById('candidate')
    const selectRegion = document.getElementById('region')
    const selectCommune = document.getElementById('commune')
    const form = document.getElementById('formVote')

    //Se hace una llamada axios para obtener la información
    axios.get('php/get_data.php')
        .then(response => {
            communes = response.data.communes

            //Se crean los candidatos
            response.data.candidates.forEach(candidate => {
                const option = document.createElement('option')
                option.value = candidate.id
                option.textContent = candidate.name

                selectCandidate.appendChild(option)
            });

            //Se crean las regiones
            response.data.regions.forEach(region => {
                const option = document.createElement('option')
                option.value = region.id
                option.textContent = region.name

                selectRegion.appendChild(option)
            });
        })
        .catch(error => {
            console.error('Error:', error);
        });

    //Se escucha el evento submit del formulario
    form.addEventListener('submit', async function (e) {
        e.preventDefault()
        let sw = false
        console.log('votando..');
        sw = await validateForm()
        const formData = new FormData(form)

        if (sw) {
            //axios para guardar el voto
            axios.post('php/insert_vote.php', formData)
                .then(response => {
                    //LIMPIAR FORM
                    form.reset()
                    selectCommune.innerHTML = ""
                    alert(response.data)
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    })

    //Se escucha el evento change del select de region
    selectRegion.addEventListener('change', function () {
        //Se limpia el select de comunas
        selectCommune.innerHTML = ''

        //Se obtienen las comunas que coindicen con la region actual
        let communesToSelect = communes.filter(commune => commune.region_id === this.value)

        //Crear option en blanco por default
        const option = document.createElement('option')
        option.value = ''
        option.textContent = ''

        selectCommune.appendChild(option)

        //Se crean las comunas
        communesToSelect.forEach(commune => {
            const option = document.createElement('option')
            option.value = commune.id
            option.textContent = commune.name

            selectCommune.appendChild(option)
        });

    })
});

const validateForm = async() => {
    let sw

    const aliasRegex = /(?=.*[a-zA-Z])(?=.*\d)/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    //Definir values
    const name = document.getElementById('name').value
    const alias = document.getElementById('alias').value
    let rut = document.getElementById('rut')
    //let rut = inputRut.value
    const email = document.getElementById('email').value
    const region = document.getElementById('region').value
    const commune = document.getElementById('commune').value
    const candidate = document.getElementById('candidate').value
    const checkboxes = document.querySelectorAll('input[type="checkbox"]')

    //Validate name
    if (name.trim() === '') {
        sw = false
        alert('El nombre no debe quedar en blanco')
    }
    //Validate alias
    if (alias.trim() === '') {
        sw = false
        alert('El alias no debe quedar en blanco')
    } else {
        if (!aliasRegex.test(alias)) {
            sw = false
            alert('El alias debe contener letras y números')
        }
        if (alias.length < 5) {
            sw = false
            alert('El alias debe ser mayor a 5 caracteres')
        }
    }
    //Validate rut
    rut.value = rut.value.replace(/\./g, '');
    rut.value = rut.value.trim()

    if (rut.value === '') {
        sw = false
        alert('El RUT no debe quedar en blanco')
    } else {
        sw = await validateRut(rut.value)
    }

    //Validate email
    if (email.trim() === '') {
        sw = false
        alert('El email no debe quedar en blanco')
    } else {
        if (!emailRegex.test(email)) {
            sw = false
            alert('El formato de email es inválido')
        }
    }
    //Validate region
    if (region.trim() === '') {
        sw = false
        alert('La región no debe quedar en blanco')
    }
    //Validate commune
    if (commune.trim() === '') {
        sw = false
        alert('La comuna no debe quedar en blanco')
    }
    //Validate candidate
    if (candidate.trim() === '') {
        sw = false
        alert('El candidato no debe quedar en blanco')
    }
    //Validate socials
    let checkedCount = 0;
    checkboxes.forEach(function (checkbox) {
        if (checkbox.checked) {
            checkedCount++
        }
    });

    if (checkedCount < 2) {
        alert('Debes seleccionar al menos 2 opciones')
        sw = false
    }

    return sw
}

const validateRut = async (rut_original) => {
    let sw
    let rut = rut_original

    if (rut.length < 9) {
        alert('Error en la longitud del RUT')
        return false;
    }

    rut = rut.replace(/[^0-9Kk]/g, '').toUpperCase();

    // Extraer dígito verificador y número
    const dv = rut.charAt(rut.length - 1);
    const rutNumerico = rut.substring(0, rut.length - 1);

    // Calcular dígito verificador
    let suma = 0;
    let multiplo = 2;

    for (let i = rutNumerico.length - 1; i >= 0; i--) {
        suma += multiplo * rutNumerico.charAt(i);
        multiplo = (multiplo === 7) ? 2 : multiplo + 1;
    }

    const dvCalculado = 11 - (suma % 11);
    const dvEsperado = (dvCalculado === 11) ? '0' : (dvCalculado === 10) ? 'K' : dvCalculado.toString();

    sw = dv === dvEsperado

    if (sw == false) {
        alert('RUT incorrecto')
    }else{
        await axios.get('php/check_duplicated_rut.php',{params:{rut:rut_original}})
            .then(response => {
                if(response.data == 'duplicated'){
                    alert('Ya existe un voto con el RUT ingresado')
                    document.getElementById('rut').value = ''
                    document.getElementById('rut').focus()
                    sw = false
                }
            })
            .catch(error =>{
                alert('Error al validar RUT duplicado')
                sw = false
            })
    }

    return sw;
}