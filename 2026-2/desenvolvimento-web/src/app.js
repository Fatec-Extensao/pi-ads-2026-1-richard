'use strict';
// Demonstração estática: nenhum formulário faz requisições ou grava respostas.
(() => {
  const USED_KEY = 'pi-demo-codigo-utilizado';
  const demoUsed = () => { try { return sessionStorage.getItem(USED_KEY) === '1'; } catch { return false; } };
  const markUsed = () => { try { sessionStorage.setItem(USED_KEY, '1'); return true; } catch { return false; } };
  const demoCode = 'DEMO2026';
  let sent = false;
  const file = location.pathname.split('/').pop();
  const forms = document.querySelectorAll('form');
  const controls = form => [...form.querySelectorAll('input, select, textarea')].filter(c => !c.disabled && c.type !== 'hidden');

  function message(form, text, error = false) {
    const output = form.querySelector('[data-feedback]');
    output.textContent = text;
    output.classList.toggle('erro', error);
    if (error) output.setAttribute('role', 'alert');
    else output.setAttribute('role', 'status');
  }
  function fieldError(field, text) {
    field.setAttribute('aria-invalid', text ? 'true' : 'false');
    const output = document.getElementById(`${field.id}-erro`);
    if (output) output.textContent = text;
  }
  function validateField(field, form) {
    field.setCustomValidity('');
    let error = '';
    if (field.required && ['text','email','password','textarea'].includes(field.type) && !field.value.trim()) error = 'Preencha este campo.';
    else if (!field.checkValidity()) {
      if (field.validity.valueMissing) error = field.type === 'checkbox' ? 'Confirme a leitura para continuar.' : 'Selecione ou preencha uma opção.';
      else if (field.validity.typeMismatch) error = 'Informe um e-mail válido.';
      else if (field.validity.rangeUnderflow || field.validity.rangeOverflow) error = `Informe um valor de ${field.min} a ${field.max}.`;
      else if (field.validity.stepMismatch) error = 'Informe uma quantidade inteira.';
      else error = 'Confira o formato informado.';
    }
    if (!error && field.value) {
      const len = field.type === 'password' ? field.value.length : field.value.trim().length;
      if (field.minLength > 0 && len < field.minLength) error = `Use pelo menos ${field.minLength} caracteres.`;
      else if (field.maxLength > 0 && len > field.maxLength) error = `Use no máximo ${field.maxLength} caracteres.`;
    }
    if (!error && field.id === 'fim' && form.querySelector('#inicio')?.value > field.value) error = 'A data final deve ser igual ou posterior à data inicial.';
    if (!error && ['senha-acesso','senha-validar'].includes(field.id) && !/^[A-Z0-9]{8}$/.test(field.value.trim().toUpperCase())) error = 'Use exatamente 8 letras ou números.';
    if (error) field.setCustomValidity(error);
    fieldError(field, error);
    return !error;
  }
  function validate(fields, form) {
    let first;
    for (const field of fields) if (!validateField(field, form)) first ||= field;
    if (first) {
      message(form, 'Confira os campos indicados antes de continuar.', true);
      first.focus();
      return false;
    }
    message(form, '');
    return true;
  }

  for (const form of forms) {
    form.noValidate = true;
    for (const button of form.querySelectorAll('[type="submit"]')) button.disabled = false;
    const output = document.createElement('p');
    output.dataset.feedback = '';
    output.className = 'feedback';
    output.setAttribute('aria-live', 'polite');
    form.append(output);
    for (const field of controls(form)) {
      if (!field.id) continue;
      const hint = document.createElement('small');
      hint.id = `${field.id}-erro`;
      hint.className = 'campo-erro';
      field.insertAdjacentElement('afterend', hint);
      field.setAttribute('aria-describedby', [field.getAttribute('aria-describedby'), hint.id].filter(Boolean).join(' '));
      field.addEventListener('input', () => {
        field.setCustomValidity('');
        fieldError(field, '');
        if (field.type === 'radio') for (const peer of controls(form).filter(c => c.name === field.name)) { peer.setCustomValidity(''); fieldError(peer, ''); }
      });
      field.addEventListener('blur', () => validateField(field, form));
    }
    form.addEventListener('reset', () => {
      for (const field of controls(form)) { field.setCustomValidity(''); fieldError(field, ''); }
      message(form, '');
    });
    form.addEventListener('submit', event => {
      event.preventDefault(); // Não enviar nem credenciais nem respostas para hospedagem estática.
      if (sent) return;
      const steps = [...form.querySelectorAll('[data-step]')];
      if (steps.length) {
        const current = steps.find(s => !s.hidden);
        if (!validate([...current.querySelectorAll('input,textarea,select')], form)) return;
        // Revalida tudo, inclusive perguntas anteriores, revelando a etapa com erro.
        for (let i=0; i<steps.length; i++) {
          const fields = [...steps[i].querySelectorAll('input,textarea,select')];
          if (fields.some(f => !validateField(f, form))) { showStep(i); validate(fields, form); return; }
        }
        sent = true;
        const retained = markUsed();
        form.reset();
        form.querySelector('[data-wizard]').hidden = true;
        message(form, 'Demonstração concluída. As respostas foram descartadas e não foram enviadas.' + (retained ? ' O código de exemplo fica bloqueado nesta aba até usar “Reiniciar demonstração”.' : ' O navegador não permitiu memorizar o bloqueio nesta aba.'));
        output.tabIndex = -1;
        output.focus();
        return;
      }
      if (!validate(controls(form), form)) return;
      if (/rf0[89]-/.test(file)) {
        const code = form.querySelector('input').value.trim().toUpperCase();
        if (code !== demoCode) { message(form, 'Código não encontrado nesta demonstração. Use DEMO2026.', true); return; }
        if (demoUsed()) { message(form, 'Código de demonstração já utilizado nesta aba. Reinicie a demonstração na página de resposta.', true); return; }
        location.href = 'rf10-responder-questionario.html';
      } else {
        form.reset();
        message(form, file === 'login.html' ? 'Exemplo validado. Nenhum login foi realizado; suas credenciais não foram enviadas nem salvas.' : 'Campos validados nesta demonstração. Nenhum dado foi enviado ou salvo.');
      }
    });
  }

  const wizard = document.querySelector('[data-wizard]');
  let activeStep = 0;
  function showStep(index) {
    const steps = [...document.querySelectorAll('[data-step]')];
    activeStep = index;
    for (let i=0; i<steps.length; i++) steps[i].hidden = i !== index;
    document.querySelector('[data-progress]').textContent = `Pergunta ${index + 1} de ${steps.length}`;
    document.querySelector('[data-back]').disabled = index === 0;
    document.querySelector('[data-next]').hidden = index === steps.length - 1;
    document.querySelector('[data-submit]').hidden = index !== steps.length - 1;
    const heading = steps[index].querySelector('legend');
    heading.tabIndex = -1;
    heading.focus();
    message(wizard.closest('form'), '');
  }
  if (wizard) {
    const steps = [...wizard.querySelectorAll('[data-step]')];
    const form = wizard.closest('form');
    const submit = form.querySelector('[data-submit]');
    submit.disabled = false;
    form.querySelector('[data-back]').addEventListener('click', () => showStep(activeStep-1));
    form.querySelector('[data-next]').addEventListener('click', () => {
      if (validate([...steps[activeStep].querySelectorAll('input,textarea,select')], form)) showStep(activeStep+1);
    });
    // Não move o foco no carregamento inicial.
    steps.forEach((s,i) => { s.hidden = i !== 0; });
    form.querySelector('[data-next]').hidden = false;
    submit.hidden = true;
    document.querySelector('[data-restart]').addEventListener('click', () => {
      try { sessionStorage.removeItem(USED_KEY); } catch { /* modo privado */ }
      sent = false;
      form.reset();
      wizard.hidden = false;
      showStep(0);
    });
    if (demoUsed()) {
      wizard.hidden = true;
      message(form, 'Código de demonstração já utilizado nesta aba. Use “Reiniciar demonstração” para testar novamente.', true);
    }
  }
})();
